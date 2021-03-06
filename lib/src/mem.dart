import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;

class Mem {
  ffi.Pointer<clMemStruct> mem;
  OpenCL dcl;
  Mem(this.mem, this.dcl);
  void retain() {
    int ret = dcl.clRetainMemObject(mem);
    assert(ret == CL_SUCCESS);
  }

  void release() {
    int ret = dcl.clReleaseMemObject(mem);
    assert(ret == CL_SUCCESS);
  }
}
