import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;


import 'package:ffi/ffi.dart' as ffilib;
import 'package:opencl/src/mem.dart';
import 'package:opencl/src/native_buffer.dart';
import 'package:opencl/src/native_cl.dart';
import 'package:opencl/src/program.dart';

class Context {
  cl_context context;
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

  CommandQueue createCommandQueue(Device device, {bool outOfOrder = false}) {
    ffi.Pointer<ffi.Int32> errcode_ret = ffilib.calloc<ffi.Int32>();
    ffi.Pointer<ffi.Uint64> properties =
        ffilib.calloc<ffi.UnsignedLong>(3).cast();
    int last_property = 0;
    if (outOfOrder) {
      properties[0] = CL_QUEUE_PROPERTIES;
      properties[1] = CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE;
      last_property = 2;
    }
    properties[last_property] = 0;
    var commandQueue = dcl.clCreateCommandQueueWithProperties(
        context, device.device, properties, errcode_ret);
    assert(errcode_ret.value == CL_SUCCESS);

    ffilib.calloc.free(errcode_ret);
    ffilib.calloc.free(properties);
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
    if (kernelRead && kernelWrite) {
      flags |= CL_MEM_READ_WRITE;
    } else {
      if (kernelRead) flags |= CL_MEM_READ_ONLY;
      if (kernelWrite) flags |= CL_MEM_WRITE_ONLY;
    }
    ffi.Pointer<ffi.Int32> errcode_ret = ffilib.calloc<ffi.Int32>();

    cl_mem memPtr = dcl.clCreateBuffer(this.context, flags,
        size, hostData?.ptr.cast() ?? ffi.nullptr, errcode_ret);
    assert(errcode_ret.value == CL_SUCCESS);

    ffilib.calloc.free(errcode_ret);

    return Mem(memPtr, dcl);
  }

  Program createProgramWithSource(List<String> strings) {
    List<ffi.Pointer<ffilib.Utf8>> nativeStrings =
        strings.map((e) => e.toNativeUtf8()).toList();

    int count = nativeStrings.length;
    ffi.Pointer<ffi.Pointer<ffilib.Utf8>> stringsPtr =
        ffilib.calloc<ffi.Pointer<ffilib.Utf8>>(count).cast();
    ffi.Pointer<ffi.Size> lengthsPtr = ffilib.calloc<ffi.Size>(count).cast();
    for (int i = 0; i < count; ++i) {
      stringsPtr[i] = nativeStrings[i];
      lengthsPtr[i] = strings[i].length;
    }
    ffi.Pointer<ffi.Int32> errcode_ret = ffilib.calloc<ffi.Int32>();

    cl_program program = dcl.clCreateProgramWithSource(
        this.context, count, stringsPtr.cast(), lengthsPtr, errcode_ret);

    assert(errcode_ret.value == CL_SUCCESS);

    ffilib.calloc.free(errcode_ret);

    nativeStrings.forEach((element) {
      ffilib.calloc.free(element);
    });
    ffilib.calloc.free(stringsPtr);
    ffilib.calloc.free(lengthsPtr);
    return Program(program, dcl);
  }
}
