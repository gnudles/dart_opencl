import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;
import 'package:opencl/src/kernel.dart';

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
  /// Builds the program. (wraps clBuildProgram)
  /// 
  /// Please read the manual of clBuildProgram.
  /// The build logs will be appended to the supplied buildLogs list.
  int buildProgram(
      List<Device> devices, String options, List<String> buildLogs) {
    ffi.Pointer<ffi.Pointer<clDeviceIdStruct>> devices_handles =
        ffilib.calloc<ffi.Pointer<clDeviceIdStruct>>(devices.length);
    for (int i = 0; i < devices.length; ++i) {
      devices_handles[i] = devices[i].device;
    }
    ffi.Pointer<ffilib.Utf8> nativeOptions = options.toNativeUtf8();
    int errcode = dcl.clBuildProgram(this.program, devices.length,
        devices_handles, nativeOptions.cast(), ffi.nullptr, ffi.nullptr);
    if (errcode == CL_BUILD_PROGRAM_FAILURE) {
      const LOG_SIZE = 4096;
      ffi.Pointer<ffilib.Utf8> build_log =
          ffilib.calloc<ffi.Char>(LOG_SIZE).cast();
      ffi.Pointer<ffi.Size> ret_size = ffilib.calloc<ffi.Size>().cast();

      for (var device in devices) {
        dcl.clGetProgramBuildInfo(this.program, device.device,
            CL_PROGRAM_BUILD_LOG, LOG_SIZE, build_log.cast(), ret_size);

        buildLogs.add(build_log.toDartString());
      }
      ffilib.calloc.free(ret_size);
      ffilib.calloc.free(build_log);
    }

    ffilib.calloc.free(devices_handles);
    ffilib.calloc.free(nativeOptions);
    return errcode;
  }

  Kernel createKernel(String kernelName) {
    ffi.Pointer<ffi.Int32> errcode_ret = ffilib.calloc<ffi.Int32>();
    ffi.Pointer<ffilib.Utf8> nativeName = kernelName.toNativeUtf8();

    ffi.Pointer<clKernelStruct> kernel =
        dcl.clCreateKernel(this.program, nativeName.cast(), errcode_ret);
    assert(errcode_ret.value == CL_SUCCESS);
    ffilib.calloc.free(errcode_ret);
    ffilib.calloc.free(nativeName);
    return Kernel(kernel, dcl);
  }
}
