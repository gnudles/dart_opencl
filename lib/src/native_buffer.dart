import 'dart:typed_data';

import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;



import 'package:ffi/ffi.dart' as ffilib;

class NativeBuffer {
  bool allocationOwner;
  ffi.Pointer<ffi.Int8> ptr;
  late final Int8List _dartList;
  NativeBuffer(int size)
      : ptr = ffilib.calloc.allocate(size),
        allocationOwner = true {
    _dartList = ptr.asTypedList(size);
    if (ptr.address == 0) {
      throw ArgumentError("allocation failed.");
    }
  }
  NativeBuffer.view(ffi.Pointer<ffi.Int8> nativePointer, int from, int length)
      : ptr = nativePointer.elementAt(from),
        allocationOwner = false {
    _dartList = ptr.asTypedList(length);
  }

  NativeBuffer getSlice(int from, int length) {
    return NativeBuffer.view(ptr, from, length);
  }

  void free() {
    if (allocationOwner) ffilib.calloc.free(ptr);
  }

  int get size => _dartList.length;

  ByteBuffer get byteBuffer => _dartList.buffer;
  Int8List get int8List => _dartList;
}
