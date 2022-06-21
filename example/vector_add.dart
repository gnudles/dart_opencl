import 'dart:developer';
import 'dart:typed_data';

import 'package:opencl/opencl.dart';

String vAdd_kernel = """
__kernel void vector_add(__global const int *A, __global const int *B, __global int *C) {
 
    // Get the index of the current element to be processed
    int i = get_global_id(0);
 
    // Do the operation
    C[i] = A[i] + B[i];

}
""";
const LIST_SIZE = 1024;
void main() {
  final OpenCL cl = OpenCL();
  List<Platform> platforms = cl.getPlatforms();

  Context context = cl.createContext(platforms[0].devices);
  CommandQueue queue = context.createCommandQueue(platforms[0].devices[0]);
  NativeBuffer aBuf = NativeBuffer(4 * LIST_SIZE);
  NativeBuffer bBuf = NativeBuffer(4 * LIST_SIZE);
  NativeBuffer cBuf = NativeBuffer(4 * LIST_SIZE);
  Int32List aList = aBuf.byteBuffer.asInt32List();
  Int32List bList = bBuf.byteBuffer.asInt32List();
  Int32List cList = cBuf.byteBuffer.asInt32List();
  for (int i = 0; i < LIST_SIZE; ++i) {
    aList[i] = i + 1;
    bList[i] = i * 2;
    cList[i] = -1;
  }
  print(aList);
  print(bList);
  Mem aMem = context.createBuffer(4 * LIST_SIZE,
      hostData: aBuf, onlyCopy: true, kernelRead: true, kernelWrite: false);
  Mem bMem = context.createBuffer(4 * LIST_SIZE,
      hostData: bBuf, onlyCopy: true, kernelRead: true, kernelWrite: false);
  Mem cMem =
      context.createBuffer(4 * LIST_SIZE, kernelRead: false, kernelWrite: true, hostRead: true);

  Program vAddProg = context.createProgramWithSource([vAdd_kernel]);
  vAddProg.buildProgram(platforms[0].devices, "",[]);
  Kernel vAddKernel = vAddProg.createKernel("vector_add");
  vAddKernel.setKernelArgMem(0, aMem);
  vAddKernel.setKernelArgMem(1, bMem);
  vAddKernel.setKernelArgMem(2, cMem);
  queue.enqueueNDRangeKernel(vAddKernel, 1,
      globalWorkSize: [LIST_SIZE], localWorkSize: [32]);
  queue.enqueueReadBuffer(cMem, 0, LIST_SIZE * 4, cBuf, blocking: true);

  print(cList);

  queue.flush();
  queue.finish();

  queue.release();
  vAddKernel.release();
  vAddProg.release();
  aMem.release();
  bMem.release();
  cMem.release();
  aBuf.free();
  bBuf.free();
  cBuf.free();
  context.release();
}
