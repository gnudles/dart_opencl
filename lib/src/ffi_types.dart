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

