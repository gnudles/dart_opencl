import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;

enum DeviceType { CPU, GPU, ACCEL, CUSTOM }

class DeviceAndHostTimer {
  int deviceTimeStamp;
  int hostTimeStamp;
  DeviceAndHostTimer(this.deviceTimeStamp, this.hostTimeStamp);
}

const deviceTypeMap = {
  CL_DEVICE_TYPE_CPU: DeviceType.CPU,
  CL_DEVICE_TYPE_GPU: DeviceType.GPU,
  CL_DEVICE_TYPE_ACCELERATOR: DeviceType.ACCEL,
  CL_DEVICE_TYPE_CUSTOM: DeviceType.CUSTOM
};

class Device {
  ffi.Pointer<clDeviceIdStruct> device;
  OpenCL dcl;
  DeviceType type;
  String profile;
  String name;
  String vendor;
  int maxComputeUnits;
  List<String> extensions;
  int vendorId;
  int maxWorkItemDimensions;
  List<int> maxWorkItemSizes;
  int maxWorkGroupSize;
  int preferredVectorWidthChar;
  int preferredVectorWidthShort;
  int preferredVectorWidthInt;
  int preferredVectorWidthLong;
  int preferredVectorWidthFloat;
  int preferredVectorWidthDouble;
  int preferredVectorWidthHalf;

  int nativeVectorWidthChar;
  int nativeVectorWidthShort;
  int nativeVectorWidthInt;
  int nativeVectorWidthLong;
  int nativeVectorWidthFloat;
  int nativeVectorWidthDouble;
  int nativeVectorWidthHalf;

  /// in MHz
  int maxClockFrequency;
  int addressBits;
  int maxMemAllocSize;
  bool imageSupport;
  int maxReadImageArgs;
  int maxWriteImageArgs;
  int maxReadWriteImageArgs;
  String ilVersion;
  int maxParameterSize;
  int image2DMaxWidth;
  int image2DMaxHeight;
  int image3DMaxWidth;
  int image3DMaxHeight;
  int image3DMaxDepth;
  int imageMaxBufferSize;
  int imageMaxArraySize;
  int maxSamplers;
  int imagePitchAlignment;
  int imageBaseAddressAlignment;
  int maxPipeArgs;
  int pipeMaxActiveReservations;
  int pipeMaxPacketSize;
  int memBaseAddrAlign;

  ///Masked CL_​DEVICE_​SINGLE_​FP_​CONFIG
  bool fpDenorm;

  ///Masked CL_​DEVICE_​SINGLE_​FP_​CONFIG
  bool fpInfNan;

  ///Masked CL_​DEVICE_​SINGLE_​FP_​CONFIG
  bool fpRoundToNearest;

  ///Masked CL_​DEVICE_​SINGLE_​FP_​CONFIG
  bool fpRoundToZero;

  ///Masked CL_​DEVICE_​SINGLE_​FP_​CONFIG
  bool fpRoundToInf;

  ///Masked CL_​DEVICE_​SINGLE_​FP_​CONFIG
  bool fpFMA;

  ///Masked CL_​DEVICE_​SINGLE_​FP_​CONFIG
  bool fpCorrectlyRoundedDivideSqrt;

  ///Masked CL_​DEVICE_​SINGLE_​FP_​CONFIG
  bool fpSoftFloat;

  ///Masked CL_​DEVICE_​DOUBLE_​FP_​CONFIG
  bool dblDenorm;

  ///Masked CL_​DEVICE_​DOUBLE_​FP_​CONFIG
  bool dblInfNan;

  ///Masked CL_​DEVICE_​DOUBLE_​FP_​CONFIG
  bool dblRoundToNearest;

  ///Masked CL_​DEVICE_​DOUBLE_​FP_​CONFIG
  bool dblRoundToZero;

  ///Masked CL_​DEVICE_​DOUBLE_​FP_​CONFIG
  bool dblRoundToInf;

  ///Masked CL_​DEVICE_​DOUBLE_​FP_​CONFIG
  bool dblFMA;

  ///Masked CL_​DEVICE_​DOUBLE_​FP_​CONFIG
  bool dblCorrectlyRoundedDivideSqrt;

  ///Masked CL_​DEVICE_​DOUBLE_​FP_​CONFIG
  bool dblSoftFloat;

  //TODO: Add missing

  Device(
    this.device,
    this.dcl,
    this.type,
    this.profile,
    this.name,
    this.vendor,
    this.maxComputeUnits,
    this.extensions,
    this.vendorId,
    this.maxWorkItemDimensions,
    this.maxWorkItemSizes,
    this.maxWorkGroupSize,
    this.preferredVectorWidthChar,
    this.preferredVectorWidthShort,
    this.preferredVectorWidthInt,
    this.preferredVectorWidthLong,
    this.preferredVectorWidthFloat,
    this.preferredVectorWidthDouble,
    this.preferredVectorWidthHalf,
    this.nativeVectorWidthChar,
    this.nativeVectorWidthShort,
    this.nativeVectorWidthInt,
    this.nativeVectorWidthLong,
    this.nativeVectorWidthFloat,
    this.nativeVectorWidthDouble,
    this.nativeVectorWidthHalf,
    this.maxClockFrequency,
    this.addressBits,
    this.maxMemAllocSize,
    this.imageSupport,
    this.maxReadImageArgs,
    this.maxWriteImageArgs,
    this.maxReadWriteImageArgs,
    this.ilVersion,
    this.maxParameterSize,
    this.image2DMaxWidth,
    this.image2DMaxHeight,
    this.image3DMaxWidth,
    this.image3DMaxHeight,
    this.image3DMaxDepth,
    this.imageMaxBufferSize,
    this.imageMaxArraySize,
    this.maxSamplers,
    this.imagePitchAlignment,
    this.imageBaseAddressAlignment,
    this.maxPipeArgs,
    this.pipeMaxActiveReservations,
    this.pipeMaxPacketSize,
    this.memBaseAddrAlign,
    this.fpDenorm,
    this.fpInfNan,
    this.fpRoundToNearest,
    this.fpRoundToZero,
    this.fpRoundToInf,
    this.fpFMA,
    this.fpCorrectlyRoundedDivideSqrt,
    this.fpSoftFloat,
    this.dblDenorm,
    this.dblInfNan,
    this.dblRoundToNearest,
    this.dblRoundToZero,
    this.dblRoundToInf,
    this.dblFMA,
    this.dblCorrectlyRoundedDivideSqrt,
    this.dblSoftFloat,
  );

  Map<String, dynamic> toJson() {
    return {
      "type": type.toString(),
      "profile": profile,
      "name": name,
      "vendor": vendor,
      "vendorId": vendorId,
      "maxComputeUnits": maxComputeUnits,
      "extensions": extensions,
      "maxWorkItemDimensions": maxWorkItemDimensions,
      "maxWorkItemSizes": maxWorkItemSizes,
      "maxWorkGroupSize": maxWorkGroupSize,
      "preferredVectorWidthChar": preferredVectorWidthChar,
      "preferredVectorWidthShort": preferredVectorWidthShort,
      "preferredVectorWidthInt": preferredVectorWidthInt,
      "preferredVectorWidthLong": preferredVectorWidthLong,
      "preferredVectorWidthFloat": preferredVectorWidthFloat,
      "preferredVectorWidthDouble": preferredVectorWidthDouble,
      "preferredVectorWidthHalf": preferredVectorWidthHalf,
      "nativeVectorWidthChar": nativeVectorWidthChar,
      "nativeVectorWidthShort": nativeVectorWidthShort,
      "nativeVectorWidthInt": nativeVectorWidthInt,
      "nativeVectorWidthLong": nativeVectorWidthLong,
      "nativeVectorWidthFloat": nativeVectorWidthFloat,
      "nativeVectorWidthDouble": nativeVectorWidthDouble,
      "nativeVectorWidthHalf": nativeVectorWidthHalf,
      "maxClockFrequency": maxClockFrequency,
      "addressBits": addressBits,
      "maxMemAllocSize": maxMemAllocSize,
      "imageSupport": imageSupport,
      "maxReadImageArgs": maxReadImageArgs,
      "maxWriteImageArgs": maxWriteImageArgs,
      "maxReadWriteImageArgs": maxReadWriteImageArgs,
      "ilVersion": ilVersion,
      "maxParameterSize": maxParameterSize,
      "image2DMaxWidth": image2DMaxWidth,
      "image2DMaxHeight": image2DMaxHeight,
      "image3DMaxWidth": image3DMaxWidth,
      "image3DMaxHeight": image3DMaxHeight,
      "image3DMaxDepth": image3DMaxDepth,
      "imageMaxBufferSize": imageMaxBufferSize,
      "imageMaxArraySize": imageMaxArraySize,
      "maxSamplers": maxSamplers,
      "imagePitchAlignment": imagePitchAlignment,
      "imageBaseAddressAlignment": imageBaseAddressAlignment,
      "maxPipeArgs": maxPipeArgs,
      "pipeMaxActiveReservations": pipeMaxActiveReservations,
      "pipeMaxPacketSize": pipeMaxPacketSize,
      "memBaseAddrAlign": memBaseAddrAlign,
      "fpDenorm": fpDenorm,
      "fpInfNan": fpInfNan,
      "fpRoundToNearest": fpRoundToNearest,
      "fpRoundToZero": fpRoundToZero,
      "fpRoundToInf": fpRoundToInf,
      "fpFMA": fpFMA,
      "fpCorrectlyRoundedDivideSqrt": fpCorrectlyRoundedDivideSqrt,
      "fpSoftFloat": fpSoftFloat,
      "dblDenorm": dblDenorm,
      "dblInfNan": dblInfNan,
      "dblRoundToNearest": dblRoundToNearest,
      "dblRoundToZero": dblRoundToZero,
      "dblRoundToInf": dblRoundToInf,
      "dblFMA": dblFMA,
      "dblCorrectlyRoundedDivideSqrt": dblCorrectlyRoundedDivideSqrt,
      "dblSoftFloat": dblSoftFloat
    };
  }

  DeviceAndHostTimer getDeviceAndHostTimer() {
    ffi.Pointer<ffi.UnsignedLong> deviceHostBuf =
        ffilib.calloc<ffi.UnsignedLong>(2).cast();
    int ret = dcl.clGetDeviceAndHostTimer(
        device, deviceHostBuf, deviceHostBuf.elementAt(1));
    assert(ret == CL_SUCCESS);
    DeviceAndHostTimer timer = DeviceAndHostTimer(
        deviceHostBuf.value, deviceHostBuf.elementAt(1).value);
    ffilib.calloc.free(deviceHostBuf);
    return timer;
  }
}

Device createDevice(ffi.Pointer<clDeviceIdStruct> device, OpenCL dcl) {
  const strBufferSize = 4096;
  ffi.Pointer<ffilib.Utf8> strbuf =
      ffilib.calloc<ffi.Int8>(strBufferSize).cast();
  ffi.Pointer<ffi.UnsignedLong> ulongbuf =
      ffilib.calloc<ffi.UnsignedLong>().cast();
  ffi.Pointer<ffi.Uint32> uintbuf = ffilib.calloc<ffi.Uint32>().cast();
  var outSize = ffilib.calloc<ffi.Size>();
  var size_tBuffer = ffilib.calloc<ffi.Size>();

  dcl.clGetDeviceInfo(device, CL_DEVICE_TYPE, ffi.sizeOf<ffi.UnsignedLong>(),
      ulongbuf.cast(), outSize);
  DeviceType type = deviceTypeMap[ulongbuf.value] ?? DeviceType.CUSTOM;

  dcl.clGetDeviceInfo(
      device, CL_DEVICE_PROFILE, strBufferSize, strbuf.cast(), outSize);
  String profile = strbuf.toDartString();

  dcl.clGetDeviceInfo(
      device, CL_DEVICE_NAME, strBufferSize, strbuf.cast(), outSize);
  String name = strbuf.toDartString();

  dcl.clGetDeviceInfo(
      device, CL_DEVICE_VENDOR, strBufferSize, strbuf.cast(), outSize);
  String vendor = strbuf.toDartString();

  dcl.clGetDeviceInfo(
      device, CL_DEVICE_EXTENSIONS, strBufferSize, strbuf.cast(), outSize);
  List<String> extensions = strbuf.toDartString().split(RegExp(" [a-zA-Z]"));

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_COMPUTE_UNITS,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int maxComputeUnits = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_VENDOR_ID, ffi.sizeOf<ffi.Uint32>(),
      uintbuf.cast(), outSize);
  int vendorId = uintbuf.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int maxWorkItemDimensions = uintbuf.value;

  ffi.Pointer<ffi.Size> dimensionsBuf =
      ffilib.calloc<ffi.Size>(maxWorkItemDimensions);

  dcl.clGetDeviceInfo(
      device,
      CL_DEVICE_MAX_WORK_ITEM_SIZES,
      ffi.sizeOf<ffi.Size>() * maxWorkItemDimensions,
      dimensionsBuf.cast(),
      outSize);
  List<int> maxWorkItemSizes =
      List.generate(maxWorkItemDimensions, (index) => dimensionsBuf[index]);

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_WORK_GROUP_SIZE,
      ffi.sizeOf<ffi.Size>(), size_tBuffer.cast(), outSize);
  int maxWorkGroupSize = size_tBuffer.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int preferredVectorWidthChar = uintbuf.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int preferredVectorWidthShort = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int preferredVectorWidthInt = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int preferredVectorWidthLong = uintbuf.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int preferredVectorWidthFloat = uintbuf.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int preferredVectorWidthDouble = uintbuf.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int preferredVectorWidthHalf = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int nativeVectorWidthChar = uintbuf.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int nativeVectorWidthShort = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_NATIVE_VECTOR_WIDTH_INT,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int nativeVectorWidthInt = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int nativeVectorWidthLong = uintbuf.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int nativeVectorWidthFloat = uintbuf.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int nativeVectorWidthDouble = uintbuf.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int nativeVectorWidthHalf = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_CLOCK_FREQUENCY,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int maxClockFrequency = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_ADDRESS_BITS, ffi.sizeOf<ffi.Uint32>(),
      uintbuf.cast(), outSize);
  int addressBits = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_MEM_ALLOC_SIZE,
      ffi.sizeOf<ffi.UnsignedLong>(), ulongbuf.cast(), outSize);
  int maxMemAllocSize = ulongbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE_SUPPORT, ffi.sizeOf<ffi.Uint32>(),
      uintbuf.cast(), outSize);
  bool imageSupport = uintbuf.value != 0;

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_READ_IMAGE_ARGS,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int maxReadImageArgs = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_WRITE_IMAGE_ARGS,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int maxWriteImageArgs = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_READ_WRITE_IMAGE_ARGS,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int maxReadWriteImageArgs = uintbuf.value;

  dcl.clGetDeviceInfo(
      device, CL_DEVICE_IL_VERSION, strBufferSize, strbuf.cast(), outSize);
  String ilVersion = strbuf.toDartString();

  /*
  CL_DEVICE_IMAGE2D_MAX_WIDTH
  CL_DEVICE_IMAGE2D_MAX_HEIGHT
  CL_DEVICE_IMAGE3D_MAX_WIDTH
  CL_DEVICE_IMAGE3D_MAX_HEIGHT
  CL_DEVICE_IMAGE3D_MAX_DEPTH
  CL_DEVICE_IMAGE_MAX_BUFFER_SIZE
  CL_DEVICE_IMAGE_MAX_ARRAY_SIZE*/

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_PARAMETER_SIZE,
      ffi.sizeOf<ffi.Size>(), size_tBuffer.cast(), outSize);
  int maxParameterSize = size_tBuffer.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE2D_MAX_WIDTH,
      ffi.sizeOf<ffi.Size>(), size_tBuffer.cast(), outSize);
  int image2DMaxWidth = size_tBuffer.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE2D_MAX_HEIGHT,
      ffi.sizeOf<ffi.Size>(), size_tBuffer.cast(), outSize);
  int image2DMaxHeight = size_tBuffer.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE3D_MAX_WIDTH,
      ffi.sizeOf<ffi.Size>(), size_tBuffer.cast(), outSize);
  int image3DMaxWidth = size_tBuffer.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE3D_MAX_HEIGHT,
      ffi.sizeOf<ffi.Size>(), size_tBuffer.cast(), outSize);
  int image3DMaxHeight = size_tBuffer.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE3D_MAX_DEPTH,
      ffi.sizeOf<ffi.Size>(), size_tBuffer.cast(), outSize);
  int image3DMaxDepth = size_tBuffer.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE_MAX_BUFFER_SIZE,
      ffi.sizeOf<ffi.Size>(), size_tBuffer.cast(), outSize);
  int imageMaxBufferSize = size_tBuffer.value;
  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE_MAX_ARRAY_SIZE,
      ffi.sizeOf<ffi.Size>(), size_tBuffer.cast(), outSize);
  int imageMaxArraySize = size_tBuffer.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_SAMPLERS, ffi.sizeOf<ffi.Uint32>(),
      uintbuf.cast(), outSize);
  int maxSamplers = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE_PITCH_ALIGNMENT,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int imagePitchAlignment = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int imageBaseAddressAlignment = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_MAX_PIPE_ARGS, ffi.sizeOf<ffi.Uint32>(),
      uintbuf.cast(), outSize);
  int maxPipeArgs = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_PIPE_MAX_ACTIVE_RESERVATIONS,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int pipeMaxActiveReservations = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_PIPE_MAX_PACKET_SIZE,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int pipeMaxPacketSize = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_MEM_BASE_ADDR_ALIGN,
      ffi.sizeOf<ffi.Uint32>(), uintbuf.cast(), outSize);
  int memBaseAddrAlign = uintbuf.value;

  dcl.clGetDeviceInfo(device, CL_DEVICE_SINGLE_FP_CONFIG,
      ffi.sizeOf<ffi.UnsignedLong>(), ulongbuf.cast(), outSize);
  int singleFPConfig = ulongbuf.value;
  bool fpDenorm = (singleFPConfig & CL_FP_DENORM) != 0;
  bool fpInfNan = (singleFPConfig & CL_FP_INF_NAN) != 0;
  bool fpRoundToNearest = (singleFPConfig & CL_FP_ROUND_TO_NEAREST) != 0;
  bool fpRoundToZero = (singleFPConfig & CL_FP_ROUND_TO_ZERO) != 0;
  bool fpRoundToInf = (singleFPConfig & CL_FP_ROUND_TO_INF) != 0;
  bool fpFMA = (singleFPConfig & CL_FP_FMA) != 0;
  bool fpCorrectlyRoundedDivideSqrt =
      (singleFPConfig & CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT) != 0;
  bool fpSoftFloat = (singleFPConfig & CL_FP_SOFT_FLOAT) != 0;

  dcl.clGetDeviceInfo(device, CL_DEVICE_DOUBLE_FP_CONFIG,
      ffi.sizeOf<ffi.UnsignedLong>(), ulongbuf.cast(), outSize);
  int doubleFPConfig = ulongbuf.value;
  bool dblDenorm = (doubleFPConfig & CL_FP_DENORM) != 0;
  bool dblInfNan = (doubleFPConfig & CL_FP_INF_NAN) != 0;
  bool dblRoundToNearest = (doubleFPConfig & CL_FP_ROUND_TO_NEAREST) != 0;
  bool dblRoundToZero = (doubleFPConfig & CL_FP_ROUND_TO_ZERO) != 0;
  bool dblRoundToInf = (doubleFPConfig & CL_FP_ROUND_TO_INF) != 0;
  bool dblFMA = (doubleFPConfig & CL_FP_FMA) != 0;
  bool dblCorrectlyRoundedDivideSqrt =
      (doubleFPConfig & CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT) != 0;
  bool dblSoftFloat = (doubleFPConfig & CL_FP_SOFT_FLOAT) != 0;

  ffilib.calloc.free(strbuf);
  ffilib.calloc.free(outSize);
  ffilib.calloc.free(ulongbuf);
  ffilib.calloc.free(uintbuf);
  ffilib.calloc.free(size_tBuffer);
  ffilib.calloc.free(dimensionsBuf);
  return Device(
      device,
      dcl,
      type,
      profile,
      name,
      vendor,
      maxComputeUnits,
      extensions,
      vendorId,
      maxWorkItemDimensions,
      maxWorkItemSizes,
      maxWorkGroupSize,
      preferredVectorWidthChar,
      preferredVectorWidthShort,
      preferredVectorWidthInt,
      preferredVectorWidthLong,
      preferredVectorWidthFloat,
      preferredVectorWidthDouble,
      preferredVectorWidthHalf,
      nativeVectorWidthChar,
      nativeVectorWidthShort,
      nativeVectorWidthInt,
      nativeVectorWidthLong,
      nativeVectorWidthFloat,
      nativeVectorWidthDouble,
      nativeVectorWidthHalf,
      maxClockFrequency,
      addressBits,
      maxMemAllocSize,
      imageSupport,
      maxReadImageArgs,
      maxWriteImageArgs,
      maxReadWriteImageArgs,
      ilVersion,
      maxParameterSize,
      image2DMaxWidth,
      image2DMaxHeight,
      image3DMaxWidth,
      image3DMaxHeight,
      image3DMaxDepth,
      imageMaxBufferSize,
      imageMaxArraySize,
      maxSamplers,
      imagePitchAlignment,
      imageBaseAddressAlignment,
      maxPipeArgs,
      pipeMaxActiveReservations,
      pipeMaxPacketSize,
      memBaseAddrAlign,
      fpDenorm,
      fpInfNan,
      fpRoundToNearest,
      fpRoundToZero,
      fpRoundToInf,
      fpFMA,
      fpCorrectlyRoundedDivideSqrt,
      fpSoftFloat,
      dblDenorm,
      dblInfNan,
      dblRoundToNearest,
      dblRoundToZero,
      dblRoundToInf,
      dblFMA,
      dblCorrectlyRoundedDivideSqrt,
      dblSoftFloat);
}
