import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;

class Event
{
  ffi.Pointer<clEventStruct> event;
  OpenCL dcl;
  Event(this.event, this.dcl);
  void retain() {
    int ret = dcl.clRetainEvent(event);
    assert(ret == CL_SUCCESS);
  }

  void release() {
    int ret = dcl.clReleaseEvent(event);
    assert(ret == CL_SUCCESS);
  }
}

