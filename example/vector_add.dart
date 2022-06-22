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
const SIZEOF_INT32 = 4;

void main() {
  final OpenCL cl = OpenCL();
  List<Platform> platforms = cl.getPlatforms();
  // get first platform with at least one gpu device.
  Platform gpuPlatform = platforms.firstWhere((platform) =>
      platform.devices.any((device) => device.type == DeviceType.GPU));
  //get the first gpu device
  Device gpuDevice =
      gpuPlatform.devices.firstWhere((device) => device.type == DeviceType.GPU);
  print("executing on ${gpuDevice.name}");

  Context context = cl.createContext([gpuDevice]);
  CommandQueue queue = context.createCommandQueue(gpuDevice);
  NativeBuffer aBuf = NativeBuffer(SIZEOF_INT32 * LIST_SIZE);
  NativeBuffer bBuf = NativeBuffer(SIZEOF_INT32 * LIST_SIZE);
  NativeBuffer cBuf = NativeBuffer(SIZEOF_INT32 * LIST_SIZE);
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
  Mem aMem = context.createBuffer(SIZEOF_INT32 * LIST_SIZE,
      hostData: aBuf, onlyCopy: true, kernelRead: true, kernelWrite: false);
  Mem bMem = context.createBuffer(SIZEOF_INT32 * LIST_SIZE,
      hostData: bBuf, onlyCopy: true, kernelRead: true, kernelWrite: false);
  Mem cMem = context.createBuffer(SIZEOF_INT32 * LIST_SIZE,
      kernelRead: false, kernelWrite: true, hostRead: true);

  Program vAddProg = context.createProgramWithSource([vAdd_kernel]);
  vAddProg.buildProgram([gpuDevice], "", []);
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
