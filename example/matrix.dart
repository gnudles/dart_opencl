import 'dart:developer';
import 'dart:math';
import 'dart:typed_data';

import 'package:opencl/opencl.dart';

String vMatMulVecKern = """
__kernel void mat_mul_vec(const int N,__global const float4 *mat, __global const float4 *vec, __local float4* localVec, __global float *result) {
 
    // Get the index of the current element to be processed
    int gid = get_global_id(0);
    int iloc = get_local_id(0);
    int nloc = get_local_size(0);
    int k;
    int NCeil = ((N+3)/4)*4;
    int qN = NCeil/4;
    for (k=iloc; k<qN; k+=nloc)
    {
      localVec[k] = vec[k];
    }
    barrier(CLK_LOCAL_MEM_FENCE);
    
    float4 temp = (float4)(0.0f,0.0f,0.0f,0.0f);
    int rowStart= gid*qN;
    __global float4 *row = &mat[rowStart];
    for (k=0; k<qN; ++k)
    {
      temp+=localVec[k]*row[k];
      //temp+=vec[k]*row[k];
    }
    result[gid]=temp.x+temp.y+temp.z+temp.w;
}
""";

const MAT_COLUMNS = 200;
const MAT_ROWS = 200;
const SIZEOF_FLOAT = 4;
void main() {
  final OpenCL cl = OpenCL();
  List<Platform> platforms = cl.getPlatforms();
  Context context = cl.createContext(platforms[0].devices);
  CommandQueue queue = context.createCommandQueue(platforms[0].devices[0]);
  NativeBuffer matBuf = NativeBuffer(MAT_COLUMNS * MAT_ROWS * SIZEOF_FLOAT);
  NativeBuffer vecBuf = NativeBuffer(MAT_COLUMNS * SIZEOF_FLOAT);
  NativeBuffer outBuf = NativeBuffer(MAT_ROWS * SIZEOF_FLOAT);
  Float32List matList = matBuf.byteBuffer.asFloat32List();
  Float32List vecList = vecBuf.byteBuffer.asFloat32List();
  Float32List outList = outBuf.byteBuffer.asFloat32List();
  Random r = Random();
  for (int i = 0; i < MAT_COLUMNS * MAT_ROWS; ++i) {
    matList[i] = r.nextDouble() * 2 - 1;
  }
  for (int i = 0; i < MAT_COLUMNS; ++i) {
    vecList[i] = r.nextDouble() * 2 - 1;
  }

  //print(aList);
  //print(bList);
  print("initialized random array");
  Mem matMem = context.createBuffer(MAT_COLUMNS * MAT_ROWS * SIZEOF_FLOAT,
      hostData: matBuf, onlyCopy: true, kernelRead: true, kernelWrite: false);
  Mem vecMem = context.createBuffer(MAT_COLUMNS * SIZEOF_FLOAT,
      hostData: vecBuf, onlyCopy: true, kernelRead: true, kernelWrite: false);
  Mem outMem = context.createBuffer(MAT_ROWS * SIZEOF_FLOAT,
      kernelRead: false, kernelWrite: true, hostRead: true);

  Program vAddProg = context.createProgramWithSource([vMatMulVecKern]);
  List<String> buildLogs = [];
  int buildRet = vAddProg.buildProgram(
      platforms[0].devices, "", buildLogs);
  if (buildRet == CL_BUILD_PROGRAM_FAILURE) {
    print(buildLogs);
  }
  Kernel vAddKernel = vAddProg.createKernel("mat_mul_vec");
  vAddKernel.setKernelArgInt(0, MAT_COLUMNS);
  vAddKernel.setKernelArgMem(1, matMem);
  vAddKernel.setKernelArgMem(2, vecMem);
  vAddKernel.setKernelArgLocal(3, MAT_COLUMNS * SIZEOF_FLOAT);
  vAddKernel.setKernelArgMem(4, outMem);
  print("finished compiling");
  Stopwatch stopwatch = new Stopwatch()..start();

  queue.enqueueNDRangeKernel(vAddKernel, 1,
      globalWorkSize: [MAT_ROWS], localWorkSize: [200]);
  queue.enqueueReadBuffer(outMem, 0, MAT_ROWS * SIZEOF_FLOAT, outBuf,
      blocking: true);
  stopwatch.stop();
  print('cl executed in ${stopwatch.elapsed}');

  queue.flush();
  queue.finish();

  queue.release();
  vAddKernel.release();
  vAddProg.release();
  matMem.release();
  vecMem.release();
  outMem.release();

  context.release();

  stopwatch.reset();
  stopwatch.start();

  Float32x4List matList4 = matList.buffer.asFloat32x4List();
  Float32x4List vecList4 = vecList.buffer.asFloat32x4List();
  Float32List nativeList = Float32List(MAT_ROWS);

  for (int i = 0; i < MAT_ROWS; ++i) {
    Float32x4 temp = Float32x4.zero();
    int rowStart = i * (MAT_COLUMNS ~/ 4);
    for (int j = 0; j < MAT_COLUMNS / 4; ++j) {
      temp += matList4[rowStart + j] * vecList4[j];
    }
    nativeList[i] = temp.x + temp.y + temp.z + temp.w;
  }

  print('native executed in ${stopwatch.elapsed}');
  /*
  for (int i = 0; i < MAT_ROWS; ++i) {
    if (outList[i] != nativeList[i]) {
      print("$i: ${outList[i]} != ${nativeList[i]} ");
    }
  }*/
  matBuf.free();
  vecBuf.free();
  outBuf.free();
}
