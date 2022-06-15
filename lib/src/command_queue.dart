import 'package:opencl/src/ffi_types.dart';
import 'package:opencl/src/event.dart';
import 'package:opencl/opencl.dart';

import 'dart:ffi' as ffi;

import 'package:opencl/src/constants.dart';

import 'package:ffi/ffi.dart' as ffilib;

class CommandQueue {
  ffi.Pointer<clCommandQueueStruct> commandQueue;
  OpenCL dcl;
  CommandQueue(this.commandQueue, this.dcl);
  void retain() {
    int ret = dcl.clRetainCommandQueue(commandQueue);
    assert(ret == CL_SUCCESS);
  }

  void release() {
    int ret = dcl.clReleaseCommandQueue(commandQueue);
    assert(ret == CL_SUCCESS);
  }

  void flush() {
    int ret = dcl.clFlush(commandQueue);
    assert(ret == CL_SUCCESS);
  }

  void finish() {
    int ret = dcl.clFinish(commandQueue);
    assert(ret == CL_SUCCESS);
  }

  Event? enqueueNDRangeKernel(Kernel kernel, int workDimensions,
      {required List<int> globalWorkSize,
      bool createEvent = false,
      List<int> globalWorkOffset = const [],
      List<int> localWorkSize = const [],
      List<Event> eventWaitList = const []}) {
    if (globalWorkSize.length != workDimensions) {
      throw ArgumentError(
          "The length of globalWorkSize does not match workDimensions");
    }

    ffi.Pointer<ffi.Size> global_work_size;
    global_work_size = ffilib.calloc<ffi.Size>(workDimensions);
    for (int i = 0; i < workDimensions; ++i) {
      global_work_size[i] = globalWorkSize[i];
    }
    ffi.Pointer<ffi.Size> global_work_offset = ffi.nullptr;
    if (globalWorkOffset.isNotEmpty) {
      if (globalWorkOffset.length != workDimensions) {
        throw ArgumentError(
            "The length of globalWorkOffset does not match workDimensions");
      }
      global_work_offset = ffilib.calloc<ffi.Size>(workDimensions);
      for (int i = 0; i < workDimensions; ++i) {
        global_work_offset[i] = globalWorkOffset[i];
      }
    }
    ffi.Pointer<ffi.Size> local_work_size = ffi.nullptr;
    if (localWorkSize.isNotEmpty) {
      if (localWorkSize.length != workDimensions) {
        throw ArgumentError(
            "The length of globalWorkOffset does not match workDimensions");
      }
      local_work_size = ffilib.calloc<ffi.Size>(workDimensions);
      for (int i = 0; i < workDimensions; ++i) {
        local_work_size[i] = localWorkSize[i];
      }
    }

    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list = ffi.nullptr;
    if (eventWaitList.isNotEmpty) {
      event_wait_list =
          ffilib.calloc<ffi.Pointer<clEventStruct>>(eventWaitList.length);
      for (int i = 0; i < eventWaitList.length; ++i) {
        event_wait_list[i] = eventWaitList[i].event;
      }
    }
    ffi.Pointer<ffi.Pointer<clEventStruct>> event = ffi.nullptr;
    if (createEvent) {
      event = ffilib.calloc<ffi.Pointer<clEventStruct>>();
    }
    int errcode_ret = dcl.clEnqueueNDRangeKernel(
        this.commandQueue,
        kernel.kernel,
        workDimensions,
        global_work_offset,
        global_work_size,
        local_work_size,
        eventWaitList.length,
        event_wait_list,
        event);
    print("errcode : $errcode_ret");
    assert(errcode_ret == CL_SUCCESS);

    Event? eventObj;
    if (createEvent) {
      eventObj = Event(event.value, dcl);
    }

    ffilib.calloc.free(global_work_size);
    if (global_work_offset != ffi.nullptr) {
      ffilib.calloc.free(global_work_offset);
    }
    if (local_work_size != ffi.nullptr) {
      ffilib.calloc.free(local_work_size);
    }
    if (event_wait_list != ffi.nullptr) {
      ffilib.calloc.free(event_wait_list);
    }
    if (event != ffi.nullptr) {
      ffilib.calloc.free(event);
    }
    return eventObj;
  }

/*typedef clEnqueueReadBuffer_c =  ffi.Int32 Function(
  ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clMemStruct> buffer,
    ffi.Bool blocking_read,
    ffi.Size offset,
    ffi.Size size,
    ffi.Pointer<ffi.Void> ptr,
    ffi.UnsignedInt num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);*/
  Event? _enqueueReadWriteBufferCommon(Mem buffer, int offset, int size,
      NativeBuffer ptr, clEnqueueReadBuffer_dart function,
      {bool createEvent = false,
      List<Event> eventWaitList = const [],
      bool blocking = false}) {
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list = ffi.nullptr;
    if (eventWaitList.isNotEmpty) {
      event_wait_list =
          ffilib.calloc<ffi.Pointer<clEventStruct>>(eventWaitList.length);
      for (int i = 0; i < eventWaitList.length; ++i) {
        event_wait_list[i] = eventWaitList[i].event;
      }
    }
    ffi.Pointer<ffi.Pointer<clEventStruct>> event = ffi.nullptr;
    if (createEvent) {
      event = ffilib.calloc<ffi.Pointer<clEventStruct>>();
    }
    int errcode_ret = function(this.commandQueue, buffer.mem, blocking, offset,
        size, ptr.ptr.cast(), eventWaitList.length, event_wait_list, event);
    print("read errcode : $errcode_ret");
    assert(errcode_ret == CL_SUCCESS);

    Event? eventObj;
    if (createEvent) {
      eventObj = Event(event.value, dcl);
    }

    if (event_wait_list != ffi.nullptr) {
      ffilib.calloc.free(event_wait_list);
    }
    if (event != ffi.nullptr) {
      ffilib.calloc.free(event);
    }
    return eventObj;
  }

  Event? enqueueReadBuffer(Mem buffer, int offset, int size, NativeBuffer ptr,
      {bool createEvent = false,
      bool blocking = false,
      List<Event> eventWaitList = const []}) {
    return _enqueueReadWriteBufferCommon(
        buffer, offset, size, ptr, dcl.clEnqueueReadBuffer,
        createEvent: createEvent,
        eventWaitList: eventWaitList,
        blocking: blocking);
  }

  Event? enqueueWriteBuffer(Mem buffer, int offset, int size, NativeBuffer ptr,
      {bool createEvent = false,
      bool blocking = false,
      List<Event> eventWaitList = const []}) {
    return _enqueueReadWriteBufferCommon(
        buffer, offset, size, ptr, dcl.clEnqueueWriteBuffer,
        createEvent: createEvent,
        eventWaitList: eventWaitList,
        blocking: blocking);
  }
}
