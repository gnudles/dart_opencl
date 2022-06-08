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
  /// size in bytes.
  Mem createBuffer(int size,
      {NativeBuffer? hostData,
      bool onlyCopy = false,
      bool kernelRead = false,
      bool kernelWrite = false,
      bool hostRead = false,
      bool hostWrite = false}) {
    if (size <= 0) {
      throw ArgumentError("size must be greater than zero");
    }
    int flags = 0;
    if ((onlyCopy || hostData == null) && (hostRead || hostWrite))
      throw ArgumentError(
          "setting onlyCopy or providing a non-null hostData forbids setting hostRead or hostWrite");
    if (onlyCopy) {
      if (hostData == null) {
        throw ArgumentError(
            "you must provide non-null hostData while setting onlyCopy");
      }
      flags |= CL_MEM_COPY_HOST_PTR;
    } else if (hostData != null) {
      flags |= CL_MEM_USE_HOST_PTR;
    }
    // TODO: very complex method.
    if (hostRead && hostWrite)
      throw ArgumentError("hostRead and hostWrite are mutually exclusive");

    if (!hostRead && !hostWrite) {
      flags |= CL_MEM_HOST_NO_ACCESS;
    } else if (hostWrite) {
      flags |= CL_MEM_HOST_WRITE_ONLY;
    } else if (hostRead) {
      flags |= CL_MEM_HOST_READ_ONLY;
    }
    if (kernelRead && kernelWrite)
    {
      flags |= CL_MEM_READ_WRITE;
    }
    else
    {
      if (kernelRead)
        flags |= CL_MEM_READ_ONLY;
      if (kernelWrite)
        flags |= CL_MEM_WRITE_ONLY;
    }
    ffi.Pointer<ffi.Int32> errcode_ret = ffilib.calloc<ffi.Int32>();

    ffi.Pointer<clMemStruct> memPtr = dcl.clCreateBuffer(
    this.context,
    flags,
    size,
    hostData?.ptr.cast() ?? ffi.nullptr,
    errcode_ret);
    assert(errcode_ret.value == CL_SUCCESS);

    ffilib.calloc.free(errcode_ret);

    return Mem(memPtr, dcl);
  }
}
