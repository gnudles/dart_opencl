import 'dart:typed_data';

import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;

class NativeBuffer {
  ffi.Pointer<ffi.Int8> ptr;
  late final Int8List _dartList;
  NativeBuffer(int size) : ptr = ffilib.calloc.allocate(size) {
    _dartList = ptr.asTypedList(size);
    if (ptr.address == 0) {
      throw ArgumentError("allocation failed.");
    }
  }
  void free() {
    ffilib.calloc.free(ptr);
  }

  int get size => _dartList.length;

  ByteBuffer get byteBuffer => _dartList.buffer;
  Int8List get int8List => _dartList;
}
