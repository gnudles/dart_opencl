import 'package:opencl/src/command_queue.dart';
import 'package:opencl/src/device.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;


import 'package:ffi/ffi.dart' as ffilib;
import 'package:opencl/src/native_cl.dart';

class Event
{
  cl_event event;
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

