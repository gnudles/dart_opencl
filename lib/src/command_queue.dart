import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;

class CommandQueue {
  ffi.Pointer<clCommandQueueStruct> commandQueue;
  OpenCL dcl;
  CommandQueue(this.commandQueue, this.dcl);
  void retain() {
    int ret = dcl.clRetainCommandQueue(commandQueue);
    assert(ret == CL_SUCCESS);
  }

  void release() {
    int ret = dcl.clReleaseCommandQueue(commandQueue);
    assert(ret == CL_SUCCESS);
  }
}
