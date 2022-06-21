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


  int setKernelArgMem(int arg_index, Mem arg_value) {
    int sizeof_clMem = ffi.sizeOf<ffi.Pointer<ffi.Void>>(); //sizeof (cl_mem) is
    // typically the size of a pointer
    ffi.Pointer<ffi.Pointer<ffi.Void>> mem_ptr =
        ffilib.calloc<ffi.Pointer<ffi.Void>>();
    mem_ptr.value = arg_value.mem.cast();
    int ret = dcl.clSetKernelArg(
        this.kernel, arg_index, sizeof_clMem, mem_ptr.cast());

    assert(ret == CL_SUCCESS);
    ffilib.calloc.free(mem_ptr);
    return ret;
  }

  int setKernelArgLocal(int arg_index, int sizeInBytes) {
    return dcl.clSetKernelArg(this.kernel, arg_index, sizeInBytes, ffi.nullptr);
  }

  int setKernelArgInt(int arg_index, int arg_value) {
    ffi.Pointer<ffi.Int32> data_ptr = ffilib.calloc<ffi.Int32>();
    data_ptr.value = arg_value;
    int ret = dcl.clSetKernelArg(
        this.kernel, arg_index, ffi.sizeOf<ffi.Int32>(), data_ptr.cast());

    assert(ret == CL_SUCCESS);
    ffilib.calloc.free(data_ptr);
    return ret;
  }

  int setKernelArgLong(int arg_index, int arg_value) {
    ffi.Pointer<ffi.Int64> data_ptr = ffilib.calloc<ffi.Int64>();
    data_ptr.value = arg_value;
    int ret = dcl.clSetKernelArg(
        this.kernel, arg_index, ffi.sizeOf<ffi.Int64>(), data_ptr.cast());

    assert(ret == CL_SUCCESS);
    ffilib.calloc.free(data_ptr);
    return ret;
  }

  int setKernelArgFloat(int arg_index, double arg_value) {
    ffi.Pointer<ffi.Float> data_ptr = ffilib.calloc<ffi.Float>();
    data_ptr.value = arg_value;
    int ret = dcl.clSetKernelArg(
        this.kernel, arg_index, ffi.sizeOf<ffi.Float>(), data_ptr.cast());

    assert(ret == CL_SUCCESS);
    ffilib.calloc.free(data_ptr);
    return ret;
  }

  int setKernelArgDouble(int arg_index, double arg_value) {
    ffi.Pointer<ffi.Double> data_ptr = ffilib.calloc<ffi.Double>();
    data_ptr.value = arg_value;
    int ret = dcl.clSetKernelArg(
        this.kernel, arg_index, ffi.sizeOf<ffi.Double>(), data_ptr.cast());

    assert(ret == CL_SUCCESS);
    ffilib.calloc.free(data_ptr);
    return ret;
  }
}
