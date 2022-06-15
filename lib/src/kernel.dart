import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;

class Kernel {
  ffi.Pointer<clKernelStruct> kernel;
  OpenCL dcl;
  Kernel(this.kernel, this.dcl);

  void retain() {
    int ret = dcl.clRetainKernel(kernel);
    assert(ret == CL_SUCCESS);
  }

  void release() {
    int ret = dcl.clReleaseKernel(kernel);
    assert(ret == CL_SUCCESS);
  }
  int setKernelArgMem(int arg_index, Mem arg_value)
  {
    int sizeof_clMem = ffi.sizeOf<ffi.Pointer<ffi.Void>>(); //sizeof (cl_mem) is
    return dcl.clSetKernelArg(this.kernel,arg_index, sizeof_clMem, arg_value.mem.cast());
    // typically the size of a pointer

  }
  int setKernelArgLocal(int arg_index, int sizeInBytes)
  {

    return dcl.clSetKernelArg(this.kernel,arg_index, sizeInBytes, ffi.nullptr);

  }
  /*
  int setKernelArgInt(int arg_index, int arg_value)
  {
    
    
  }
  int setKernelArgLong(int arg_index, int arg_value)
  {
    
    
  }*/
}