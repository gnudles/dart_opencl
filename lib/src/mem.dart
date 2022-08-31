import 'package:opencl/src/command_queue.dart';

import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;



import 'package:ffi/ffi.dart' as ffilib;
import 'package:opencl/src/native_cl.dart';

class Mem {
  cl_mem mem;
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
