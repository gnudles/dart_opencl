import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;

class Program {
  ffi.Pointer<clProgramStruct> program;
  OpenCL dcl;
  Program(this.program, this.dcl);
  void retain() {
    int ret = dcl.clRetainProgram(program);
    assert(ret == CL_SUCCESS);
  }

  void release() {
    int ret = dcl.clReleaseProgram(program);
    assert(ret == CL_SUCCESS);
  }
}
