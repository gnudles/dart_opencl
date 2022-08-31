import 'dart:ffi' as ffi;

import 'dart:io' as io show Platform, Directory;
//import 'package:opencl/src/constants.dart';
import 'package:opencl/src/context.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/src/native_cl.dart';
import 'package:opencl/src/platform.dart';

import 'package:ffi/ffi.dart' as ffilib;

/// OpenCL

class OpenCL extends NativeCL {
  final ffi.DynamicLibrary openCLDynLib;

  static ffi.DynamicLibrary openDynLib() {
    var libraryPath = 'libOpenCL.so';
    if (io.Platform.isMacOS) {
      libraryPath = 'libOpenCL.dylib';
    } else if (io.Platform.isWindows) {
      libraryPath = 'OpenCL.dll';
    }
    return ffi.DynamicLibrary.open(libraryPath);
  }

  OpenCL(this.openCLDynLib) : super(openCLDynLib);

  List<Platform> getPlatforms() {
    ffi.Pointer<ffi.Uint32> num_platforms = ffilib.calloc<ffi.Uint32>();
    int ret = clGetPlatformIDs(0, ffi.nullptr, num_platforms);
    assert(ret == CL_SUCCESS);
    var platforms_list = ffilib.calloc<cl_platform_id>(num_platforms.value);
    ret = clGetPlatformIDs(num_platforms.value, platforms_list, num_platforms);
    assert(ret == CL_SUCCESS);
    var platforms = List.generate(num_platforms.value,
        (index) => createPlatform(platforms_list[index], this));
    ffilib.calloc.free(num_platforms);
    ffilib.calloc.free(platforms_list);
    return platforms;
  }

  Context createContext(List<Device> devices) {
    ffi.Pointer<ffi.Int32> errcode_ret = ffilib.calloc<ffi.Int32>();
    ffi.Pointer<cl_device_id> devices_handles =
        ffilib.calloc<cl_device_id>(devices.length);
    for (int i = 0; i < devices.length; ++i) {
      devices_handles[i] = devices[i].device;
    }

    cl_context context = clCreateContext(ffi.nullptr, devices.length,
        devices_handles, ffi.nullptr, ffi.nullptr, errcode_ret);
    assert(errcode_ret.value == CL_SUCCESS);
    ffilib.calloc.free(errcode_ret);
    ffilib.calloc.free(devices_handles);
    return Context(context, this);
  }
}
