import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;
import 'package:opencl/src/mem.dart';
import 'package:opencl/src/native_buffer.dart';

class Context {
  ffi.Pointer<clContextStruct> context;
  OpenCL dcl;
  Context(this.context, this.dcl);

  /// increments the ref-count of the context
  void retain() {
    int ret = dcl.clRetainContext(context);
    assert(ret == CL_SUCCESS);
  }

  void release() {
    int ret = dcl.clReleaseContext(context);
    assert(ret == CL_SUCCESS);
  }

  CommandQueue createCommandQueue(Device device) {
    ffi.Pointer<ffi.Int32> errcode_ret = ffilib.calloc<ffi.Int32>();
    var commandQueue = dcl.clCreateCommandQueueWithProperties(
        context, device.device, ffi.nullptr, errcode_ret);
    assert(errcode_ret.value == CL_SUCCESS);

    ffilib.calloc.free(errcode_ret);
    return CommandQueue(commandQueue, dcl);
  }

  Mem createBuffer(int size, {NativeBuffer? initialData}) { // TODO: very complex method.
    return Mem();
  }
}
