import 'dart:ffi' as ffi;

class clPlatformIdStruct extends ffi.Opaque {}
class clDeviceIdStruct extends ffi.Opaque {}
class clContextStruct extends ffi.Opaque {}
class clCommandQueueStruct extends ffi.Opaque {}
class clMemStruct extends ffi.Opaque {}
class clProgramStruct extends ffi.Opaque {}
class clKernelStruct extends ffi.Opaque {}
class clEventStruct extends ffi.Opaque {}
class clSamplerStruct extends ffi.Opaque {}




typedef clGetPlatformIDs_c = ffi.Int32 Function(
    ffi.Uint32 num_entries,
    ffi.Pointer<ffi.Pointer<clPlatformIdStruct>> platforms,
    ffi.Pointer<ffi.Uint32> num_platforms);
typedef clGetPlatformIDs_dart = int Function(
    int num_entries,
    ffi.Pointer<ffi.Pointer<clPlatformIdStruct>> platforms,
    ffi.Pointer<ffi.Uint32> num_platforms);

typedef clGetDeviceIDs_c = ffi.Int32 Function(
    ffi.Pointer<clPlatformIdStruct> platform,
    ffi.UnsignedLong device_type,
    ffi.Uint32 num_entries,
    ffi.Pointer<ffi.Pointer<clDeviceIdStruct>> devices,
    ffi.Pointer<ffi.Uint32> num_devices);
typedef clGetDeviceIDs_dart = int Function(
    ffi.Pointer<clPlatformIdStruct> platform,
    int device_type,
    int num_entries,
    ffi.Pointer<ffi.Pointer<clDeviceIdStruct>> devices,
    ffi.Pointer<ffi.Uint32> num_devices);

typedef clGetPlatformInfo_c = ffi.Int32 Function(
    ffi.Pointer<clPlatformIdStruct> platform,
    ffi.Uint32 param_name,
    ffi.Size param_value_size,
    ffi.Pointer<ffi.Void> param_value,
    ffi.Pointer<ffi.Size> param_value_size_ret);
typedef clGetPlatformInfo_dart = int Function(
    ffi.Pointer<clPlatformIdStruct> platform,
    int param_name,
    int param_value_size,
    ffi.Pointer<ffi.Void> param_value,
    ffi.Pointer<ffi.Size> param_value_size_ret);

typedef clGetDeviceInfo_c = ffi.Int32 Function(
    ffi.Pointer<clDeviceIdStruct> device,
    ffi.Uint32 param_name,
    ffi.Size param_value_size,
    ffi.Pointer<ffi.Void> param_value,
    ffi.Pointer<ffi.Size> param_value_size_ret);
typedef clGetDeviceInfo_dart = int Function(
    ffi.Pointer<clDeviceIdStruct> device,
    int param_name,
    int param_value_size,
    ffi.Pointer<ffi.Void> param_value,
    ffi.Pointer<ffi.Size> param_value_size_ret);


typedef clGetDeviceAndHostTimer_c = ffi.Int32 Function(
    ffi.Pointer<clDeviceIdStruct> device,
    ffi.Pointer<ffi.UnsignedLong> device_timestamp,
    ffi.Pointer<ffi.UnsignedLong> host_timestamp);
typedef clGetDeviceAndHostTimer_dart = int Function(
    ffi.Pointer<clDeviceIdStruct> device,
    ffi.Pointer<ffi.UnsignedLong> device_timestamp,
    ffi.Pointer<ffi.UnsignedLong> host_timestamp);

typedef clGetHostTimer_c = ffi.Int32 Function(
    ffi.Pointer<clDeviceIdStruct> device,
    ffi.Pointer<ffi.UnsignedLong> host_timestamp);
typedef clGetHostTimer_dart = int Function(
    ffi.Pointer<clDeviceIdStruct> device,
    ffi.Pointer<ffi.UnsignedLong> host_timestamp);

typedef clCallback_c = ffi.Void Function(ffi.Pointer<ffi.Char> errinfo,ffi.Pointer<ffi.Void> private_info,
    ffi.Size cb, ffi.Pointer<ffi.Void> user_data);
typedef clCreateContext_c = ffi.Pointer<clContextStruct> Function(
    ffi.Pointer<ffi.IntPtr> properties,
    ffi.Uint32 num_devices, ffi.Pointer<ffi.Pointer<clDeviceIdStruct>> devices,
    ffi.Pointer<ffi.NativeFunction<clCallback_c>> pfn_notify, ffi.Pointer<ffi.Void> user_data, ffi.Pointer<ffi.Int32> errcode_ret);
typedef clCreateContext_dart = ffi.Pointer<clContextStruct> Function(
    ffi.Pointer<ffi.IntPtr> properties,
    int num_devices, ffi.Pointer<ffi.Pointer<clDeviceIdStruct>> devices,
    ffi.Pointer<ffi.NativeFunction<clCallback_c>> pfn_notify, ffi.Pointer<ffi.Void> user_data, ffi.Pointer<ffi.Int32> errcode_ret);


typedef clRetainReleaseContext_c = ffi.Int32 Function(
    ffi.Pointer<clContextStruct> context);
typedef clRetainReleaseContext_dart = int Function(
    ffi.Pointer<clContextStruct> context);


typedef clCreateCommandQueueWithProperties_c = ffi.Pointer<clCommandQueueStruct> Function(
    ffi.Pointer<clContextStruct> context ,
    ffi.Pointer<clDeviceIdStruct> device ,
    ffi.Pointer<ffi.UnsignedLong> properties,
    ffi.Pointer<ffi.Int32> errcode_ret);
typedef clCreateCommandQueueWithProperties_dart = ffi.Pointer<clCommandQueueStruct> Function(
    ffi.Pointer<clContextStruct> context ,
    ffi.Pointer<clDeviceIdStruct> device ,
    ffi.Pointer<ffi.UnsignedLong> properties,
    ffi.Pointer<ffi.Int32> errcode_ret);

typedef clRetainReleaseCommandQueue_c = ffi.Int32 Function(
    ffi.Pointer<clCommandQueueStruct> command_queue);
typedef clRetainReleaseCommandQueue_dart = int Function(
    ffi.Pointer<clCommandQueueStruct> command_queue);

typedef clCreateBuffer_c = ffi.Pointer<clMemStruct> Function(
    ffi.Pointer<clContextStruct> context,
    ffi.UnsignedLong flags,
    ffi.Size size,
    ffi.Pointer<ffi.Void> host_ptr,
    ffi.Pointer<ffi.Int32> errcode_ret);
typedef clCreateBuffer_dart = ffi.Pointer<clMemStruct> Function(
    ffi.Pointer<clContextStruct> context,
    int flags,
    int size,
    ffi.Pointer<ffi.Void> host_ptr,
    ffi.Pointer<ffi.Int32> errcode_ret);

typedef clRetainReleaseMemObject_c = ffi.Int32 Function(
    ffi.Pointer<clMemStruct> memobj);
typedef clRetainReleaseMemObject_dart = int Function(
    ffi.Pointer<clMemStruct> memobj);

typedef clRetainReleaseProgram_c = ffi.Int32 Function(
    ffi.Pointer<clProgramStruct> program);
typedef clRetainReleaseProgram_dart = int Function(
    ffi.Pointer<clProgramStruct> program);


typedef clCreateProgramWithSource_c = ffi.Pointer<clProgramStruct> Function(
    ffi.Pointer<clContextStruct> context,
    ffi.UnsignedInt count,
    ffi.Pointer<ffi.Pointer<ffi.Char>> strings,
    ffi.Pointer<ffi.Size> lengths,
    ffi.Pointer<ffi.Int32> errcode_ret);

typedef clCreateProgramWithSource_dart = ffi.Pointer<clProgramStruct> Function(
    ffi.Pointer<clContextStruct> context,
    int count,
    ffi.Pointer<ffi.Pointer<ffi.Char>> strings,
    ffi.Pointer<ffi.Size> lengths,
    ffi.Pointer<ffi.Int32> errcode_ret);


typedef clBuildProgram_c =   ffi.Int32 Function(
    ffi.Pointer<clProgramStruct> program,
    ffi.Uint32 num_devices, ffi.Pointer<ffi.Pointer<clDeviceIdStruct>> devices,
    ffi.Pointer<ffi.Char> options,ffi.Pointer<ffi.NativeFunction<clCallback_c>> pfn_notify,
    ffi.Pointer<ffi.Void> user_data);
typedef clBuildProgram_dart =   int Function(
    ffi.Pointer<clProgramStruct> program,
    int num_devices, ffi.Pointer<ffi.Pointer<clDeviceIdStruct>> devices,
    ffi.Pointer<ffi.Char> options,ffi.Pointer<ffi.NativeFunction<clCallback_c>> pfn_notify,
    ffi.Pointer<ffi.Void> user_data);



typedef clCreateKernel_c =  ffi.Pointer<clKernelStruct> Function(
    ffi.Pointer<clProgramStruct> program,
    ffi.Pointer<ffi.Char> kernel_name,
    ffi.Pointer<ffi.Int32> errcode_ret);
typedef clCreateKernel_dart =  ffi.Pointer<clKernelStruct> Function(
    ffi.Pointer<clProgramStruct> program,
    ffi.Pointer<ffi.Char> kernel_name,
    ffi.Pointer<ffi.Int32> errcode_ret);


typedef clRetainReleaseKernel_c = ffi.Int32 Function(
    ffi.Pointer<clKernelStruct> kernel);
typedef clRetainReleaseKernel_dart = int Function(
    ffi.Pointer<clKernelStruct> kernel);



typedef clSetKernelArg_c =  ffi.Int32 Function(
    ffi.Pointer<clKernelStruct> kernel,
    ffi.UnsignedInt arg_index,
    ffi.Size arg_size,
    ffi.Pointer<ffi.Void> arg_value);
typedef clSetKernelArg_dart =  int Function(
    ffi.Pointer<clKernelStruct> kernel,
    int arg_index,
    int arg_size,
    ffi.Pointer<ffi.Void> arg_value);

typedef clEnqueueNDRangeKernel_c =  ffi.Int32 Function(
  ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clKernelStruct> kernel,
    ffi.UnsignedInt work_dim,
    ffi.Pointer<ffi.Size> global_work_offset,
    ffi.Pointer<ffi.Size> global_work_size,
    ffi.Pointer<ffi.Size> local_work_size,
    ffi.UnsignedInt num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);

typedef clEnqueueNDRangeKernel_dart =  int Function(
    ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clKernelStruct> kernel,
    int work_dim,
    ffi.Pointer<ffi.Size> global_work_offset,
    ffi.Pointer<ffi.Size> global_work_size,
    ffi.Pointer<ffi.Size> local_work_size,
    int num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event
);

typedef clRetainReleaseEvent_c = ffi.Int32 Function(
    ffi.Pointer<clEventStruct> event);
typedef clRetainReleaseEvent_dart = int Function(
    ffi.Pointer<clEventStruct> event);


typedef clEnqueueReadBuffer_c =  ffi.Int32 Function(
  ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clMemStruct> buffer,
    ffi.Bool blocking_read,
    ffi.Size offset,
    ffi.Size size,
    ffi.Pointer<ffi.Void> ptr,
    ffi.UnsignedInt num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);

typedef clEnqueueReadBuffer_dart = int Function(
    ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clMemStruct> buffer,
    bool blocking_write,
    int offset,
    int size,
    ffi.Pointer<ffi.Void> ptr,
    int num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);

typedef clEnqueueWriteBuffer_c =  ffi.Int32 Function(
  ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clMemStruct> buffer,
    ffi.Bool blocking_write,
    ffi.Size offset,
    ffi.Size size,
    ffi.Pointer<ffi.Void> ptr,
    ffi.UnsignedInt num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);

typedef clEnqueueWriteBuffer_dart = int Function(
    ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clMemStruct> buffer,
    bool blocking_write,
    int offset,
    int size,
    ffi.Pointer<ffi.Void> ptr,
    int num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);


typedef clEnqueueFillBuffer_c =  ffi.Int32 Function(
  ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clMemStruct> buffer,
    ffi.Pointer<ffi.Void> pattern,
    ffi.Size pattern_size,
    ffi.Size offset,
    ffi.Size size,
    ffi.UnsignedInt num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);

typedef clEnqueueFillBuffer_dart = int Function(
    ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clMemStruct> buffer,
    ffi.Pointer<ffi.Void> pattern,
    int pattern_size,
    int offset,
    int size,
    int num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);


typedef clEnqueueCopyBuffer_c =  ffi.Int32 Function(
  ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clMemStruct> src_buffer,
    ffi.Pointer<clMemStruct> dst_buffer,
    ffi.Size src_offset,
    ffi.Size dst_offset,
    ffi.Size size,
    ffi.UnsignedInt num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);

typedef clEnqueueCopyBuffer_dart = int Function(
    ffi.Pointer<clCommandQueueStruct> command_queue,
    ffi.Pointer<clMemStruct> src_buffer,
    ffi.Pointer<clMemStruct> dst_buffer,
    int src_offset,
    int dst_offset,
    int size,
    int num_events_in_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event_wait_list,
    ffi.Pointer<ffi.Pointer<clEventStruct>> event);
