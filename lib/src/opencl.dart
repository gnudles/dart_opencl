import 'dart:ffi' as ffi;

import 'dart:io' as io show Platform, Directory;
import 'package:opencl/src/constants.dart';
import 'package:opencl/src/context.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/src/platform.dart';
import 'package:opencl/src/ffi_types.dart';
import 'package:path/path.dart' as path;
import 'package:ffi/ffi.dart' as ffilib;

/// OpenCL

const androidLibPaths = [
  "/system/lib64/libOpenCL.so",
  "/system/vendor/lib64/libOpenCL.so",
  "/system/vendor/lib64/egl/libGLES_mali.so",
  "/system/vendor/lib64/libPVROCL.so",
  "/data/data/org.pocl.libs/files/lib64/libpocl.so",
  "/system/lib/libOpenCL.so",
  "/system/vendor/lib/libOpenCL.so",
  "/system/vendor/lib/egl/libGLES_mali.so",
  "/system/vendor/lib/libPVROCL.so",
  "/data/data/org.pocl.libs/files/lib/libpocl.so",
  "libOpenCL.so"
];

class OpenCL {
  late final ffi.DynamicLibrary openCLDynLib;
  late final clGetPlatformIDs_dart clGetPlatformIDs;
  late final clGetDeviceIDs_dart clGetDeviceIDs;
  late final clGetPlatformInfo_dart clGetPlatformInfo;
  late final clGetDeviceInfo_dart clGetDeviceInfo;
  late final clGetDeviceAndHostTimer_dart clGetDeviceAndHostTimer;
  late final clGetHostTimer_dart clGetHostTimer;
  late final clCreateContext_dart clCreateContext;
  late final clRetainReleaseContext_dart clRetainContext;
  late final clRetainReleaseContext_dart clReleaseContext;
  late final clCreateCommandQueueWithProperties_dart
      clCreateCommandQueueWithProperties;
  late final clRetainReleaseCommandQueue_dart clRetainCommandQueue;
  late final clRetainReleaseCommandQueue_dart clReleaseCommandQueue;
  late final clRetainReleaseCommandQueue_dart clFlush;
  late final clRetainReleaseCommandQueue_dart clFinish;

  late final clCreateBuffer_dart clCreateBuffer;
  late final clRetainReleaseMemObject_dart clRetainMemObject;
  late final clRetainReleaseMemObject_dart clReleaseMemObject;

  bool loadingError = false;

  OpenCL() {
    var libraryPath = 'libOpenCL.so';
    if (io.Platform.isMacOS) {
      libraryPath = 'libOpenCL.dylib';
    } else if (io.Platform.isWindows) {
      libraryPath = 'OpenCL.dll';
    }
    bool successfullyLoaded = false;
    if (io.Platform.isAndroid) {
      for (String path in androidLibPaths) {
        try {
          openCLDynLib = ffi.DynamicLibrary.open(path);
          successfullyLoaded = true;
          break;
        } catch (e) {}
      }
    }

    try {
      if (!successfullyLoaded) {
        openCLDynLib = ffi.DynamicLibrary.open(libraryPath);
      }
      clGetPlatformIDs = openCLDynLib
          .lookup<ffi.NativeFunction<clGetPlatformIDs_c>>('clGetPlatformIDs')
          .asFunction<clGetPlatformIDs_dart>();
      clGetDeviceIDs = openCLDynLib
          .lookup<ffi.NativeFunction<clGetDeviceIDs_c>>('clGetDeviceIDs')
          .asFunction<clGetDeviceIDs_dart>();
      clGetPlatformInfo = openCLDynLib
          .lookup<ffi.NativeFunction<clGetPlatformInfo_c>>('clGetPlatformInfo')
          .asFunction<clGetPlatformInfo_dart>();
      clGetDeviceInfo = openCLDynLib
          .lookup<ffi.NativeFunction<clGetDeviceInfo_c>>('clGetDeviceInfo')
          .asFunction<clGetDeviceInfo_dart>();
      clGetDeviceAndHostTimer = openCLDynLib
          .lookup<ffi.NativeFunction<clGetDeviceAndHostTimer_c>>(
              'clGetDeviceAndHostTimer')
          .asFunction<clGetDeviceAndHostTimer_dart>();
      clGetHostTimer = openCLDynLib
          .lookup<ffi.NativeFunction<clGetHostTimer_c>>('clGetHostTimer')
          .asFunction<clGetHostTimer_dart>();

      clCreateContext = openCLDynLib
          .lookup<ffi.NativeFunction<clCreateContext_c>>('clCreateContext')
          .asFunction<clCreateContext_dart>();

      clReleaseContext = openCLDynLib
          .lookup<ffi.NativeFunction<clRetainReleaseContext_c>>(
              'clReleaseContext')
          .asFunction<clRetainReleaseContext_dart>();
      clRetainContext = openCLDynLib
          .lookup<ffi.NativeFunction<clRetainReleaseContext_c>>(
              'clRetainContext')
          .asFunction<clRetainReleaseContext_dart>();
      clCreateCommandQueueWithProperties = openCLDynLib
          .lookup<ffi.NativeFunction<clCreateCommandQueueWithProperties_c>>(
              'clCreateCommandQueueWithProperties')
          .asFunction<clCreateCommandQueueWithProperties_dart>();

      clRetainCommandQueue = openCLDynLib
          .lookup<ffi.NativeFunction<clRetainReleaseCommandQueue_c>>(
              'clRetainCommandQueue')
          .asFunction<clRetainReleaseCommandQueue_dart>();
      clReleaseCommandQueue = openCLDynLib
          .lookup<ffi.NativeFunction<clRetainReleaseCommandQueue_c>>(
              'clReleaseCommandQueue')
          .asFunction<clRetainReleaseCommandQueue_dart>();
      clFlush = openCLDynLib
          .lookup<ffi.NativeFunction<clRetainReleaseCommandQueue_c>>(
              'clFlush')
          .asFunction<clRetainReleaseCommandQueue_dart>();
      clFinish = openCLDynLib
          .lookup<ffi.NativeFunction<clRetainReleaseCommandQueue_c>>(
              'clFinish')
          .asFunction<clRetainReleaseCommandQueue_dart>();
      clCreateBuffer = openCLDynLib
          .lookup<ffi.NativeFunction<clCreateBuffer_c>>('clCreateBuffer')
          .asFunction<clCreateBuffer_dart>();
      clRetainMemObject = openCLDynLib
          .lookup<ffi.NativeFunction<clRetainReleaseMemObject_c>>('clRetainMemObject')
          .asFunction<clRetainReleaseMemObject_dart>();
      clReleaseMemObject = openCLDynLib
          .lookup<ffi.NativeFunction<clRetainReleaseMemObject_c>>('clReleaseMemObject')
          .asFunction<clRetainReleaseMemObject_dart>();

    } catch (e) {
      loadingError = true;
      return;
    }
  }

  List<Platform> getPlatforms() {
    if (loadingError) return [];
    ffi.Pointer<ffi.Uint32> num_platforms = ffilib.calloc<ffi.Uint32>();
    int ret = clGetPlatformIDs(0, ffi.nullptr, num_platforms);
    assert(ret == CL_SUCCESS);
    var platforms_list =
        ffilib.calloc<ffi.Pointer<clPlatformIdStruct>>(num_platforms.value);
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
    ffi.Pointer<ffi.Pointer<clDeviceIdStruct>> devices_handles =
        ffilib.calloc<ffi.Pointer<clDeviceIdStruct>>(devices.length);
    for (int i = 0; i < devices.length; ++i) {
      devices_handles[i] = devices[i].device;
    }

    ffi.Pointer<clContextStruct> context = clCreateContext(ffi.nullptr,
        devices.length, devices_handles, ffi.nullptr, ffi.nullptr, errcode_ret);
    assert(errcode_ret.value == CL_SUCCESS);
    ffilib.calloc.free(errcode_ret);
    ffilib.calloc.free(devices_handles);
    return Context(context, this);
  }
}
