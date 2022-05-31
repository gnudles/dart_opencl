import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;

class Platform {
  ffi.Pointer<clPlatformIdStruct> platform;
  OpenCL dcl;
  List<Device> devices;
  String profile;
  String version;
  String name;
  String vendor;

  /// in nano seconds
  int hostTimerResolution;
  List<String> extensions;

  Platform(this.platform, this.dcl, this.devices, this.profile, this.version,
      this.name, this.vendor, this.extensions, this.hostTimerResolution);
}

Platform createPlatform(ffi.Pointer<clPlatformIdStruct> platform, OpenCL dcl) {
  ffi.Pointer<ffi.Uint32> num_devices = ffilib.calloc<ffi.Uint32>();
  dcl.clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, 0, ffi.nullptr, num_devices);

  var devices_list =
      ffilib.calloc<ffi.Pointer<clDeviceIdStruct>>(num_devices.value);
  dcl.clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, num_devices.value,
      devices_list, num_devices);
  var devices = List.generate(
      num_devices.value, (index) => createDevice(devices_list[index], dcl));
  //free used memory
  ffilib.calloc.free(num_devices);
  ffilib.calloc.free(devices_list);
  //I hope that's enough...
  const bufsize = 4096;
  ffi.Pointer<ffilib.Utf8> strbuf = ffilib.calloc<ffi.Int8>(bufsize).cast();
  var outSize = ffilib.calloc<ffi.Size>();
  var uLongBuf = ffilib.calloc<ffi.UnsignedLong>();

  dcl.clGetPlatformInfo(
      platform, CL_PLATFORM_PROFILE, bufsize, strbuf.cast(), outSize);
  String profile = strbuf.toDartString();

  dcl.clGetPlatformInfo(
      platform, CL_PLATFORM_VERSION, bufsize, strbuf.cast(), outSize);
  String version = strbuf.toDartString();

  //get platform name
  dcl.clGetPlatformInfo(
      platform, CL_PLATFORM_NAME, bufsize, strbuf.cast(), outSize);
  String name = strbuf.toDartString();

  //get platform vendor
  dcl.clGetPlatformInfo(
      platform, CL_PLATFORM_VENDOR, bufsize, strbuf.cast(), outSize);
  String vendor = strbuf.toDartString();

  //get platform extensions
  dcl.clGetPlatformInfo(
      platform, CL_PLATFORM_EXTENSIONS, bufsize, strbuf.cast(), outSize);
  List<String> extensions = strbuf.toDartString().split(RegExp(" [a-zA-Z]"));

  dcl.clGetPlatformInfo(platform, CL_PLATFORM_HOST_TIMER_RESOLUTION,
      ffi.sizeOf<ffi.UnsignedLong>(), uLongBuf.cast(), outSize);
  int hostTimerResolution = uLongBuf.value;

  //free used memory
  ffilib.calloc.free(strbuf);
  ffilib.calloc.free(outSize);
  ffilib.calloc.free(uLongBuf);

  return Platform(platform, dcl, devices, profile, version, name, vendor,
      extensions, hostTimerResolution);
}
