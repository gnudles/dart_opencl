const CL_SUCCESS = 0;

const CL_DEVICE_TYPE_DEFAULT = (1 << 0);
const CL_DEVICE_TYPE_CPU = (1 << 1);
const CL_DEVICE_TYPE_GPU = (1 << 2);
const CL_DEVICE_TYPE_ACCELERATOR = (1 << 3);
const CL_DEVICE_TYPE_CUSTOM = (1 << 4); //1.2
const CL_DEVICE_TYPE_ALL = 0xFFFFFFFF;

const CL_PLATFORM_PROFILE = 0x0900;
const CL_PLATFORM_VERSION = 0x0901;
const CL_PLATFORM_NAME = 0x0902;
const CL_PLATFORM_VENDOR = 0x0903;
const CL_PLATFORM_EXTENSIONS = 0x0904;
//cl2.1
const CL_PLATFORM_HOST_TIMER_RESOLUTION = 0x0905;

//cl3.0
const CL_PLATFORM_NUMERIC_VERSION = 0x0906;
const CL_PLATFORM_EXTENSIONS_WITH_VERSION = 0x0907;

const CL_DEVICE_TYPE = 0x1000;
const CL_DEVICE_VENDOR_ID = 0x1001;
const CL_DEVICE_MAX_COMPUTE_UNITS = 0x1002;
const CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS = 0x1003;
const CL_DEVICE_MAX_WORK_GROUP_SIZE = 0x1004;
const CL_DEVICE_MAX_WORK_ITEM_SIZES = 0x1005;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR = 0x1006;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT = 0x1007;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT = 0x1008;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG = 0x1009;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT = 0x100A;
const CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE = 0x100B;
const CL_DEVICE_MAX_CLOCK_FREQUENCY = 0x100C;
const CL_DEVICE_ADDRESS_BITS = 0x100D;
const CL_DEVICE_MAX_READ_IMAGE_ARGS = 0x100E;
const CL_DEVICE_MAX_WRITE_IMAGE_ARGS = 0x100F;
const CL_DEVICE_MAX_MEM_ALLOC_SIZE = 0x1010;
const CL_DEVICE_IMAGE2D_MAX_WIDTH = 0x1011;
const CL_DEVICE_IMAGE2D_MAX_HEIGHT = 0x1012;
const CL_DEVICE_IMAGE3D_MAX_WIDTH = 0x1013;
const CL_DEVICE_IMAGE3D_MAX_HEIGHT = 0x1014;
const CL_DEVICE_IMAGE3D_MAX_DEPTH = 0x1015;
const CL_DEVICE_IMAGE_SUPPORT = 0x1016;
const CL_DEVICE_MAX_PARAMETER_SIZE = 0x1017;
const CL_DEVICE_MAX_SAMPLERS = 0x1018;
const CL_DEVICE_MEM_BASE_ADDR_ALIGN = 0x1019;
const CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE = 0x101A;
const CL_DEVICE_SINGLE_FP_CONFIG = 0x101B;
const CL_DEVICE_GLOBAL_MEM_CACHE_TYPE = 0x101C;
const CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE = 0x101D;
const CL_DEVICE_GLOBAL_MEM_CACHE_SIZE = 0x101E;
const CL_DEVICE_GLOBAL_MEM_SIZE = 0x101F;
const CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE = 0x1020;
const CL_DEVICE_MAX_CONSTANT_ARGS = 0x1021;
const CL_DEVICE_LOCAL_MEM_TYPE = 0x1022;
const CL_DEVICE_LOCAL_MEM_SIZE = 0x1023;
const CL_DEVICE_ERROR_CORRECTION_SUPPORT = 0x1024;
const CL_DEVICE_PROFILING_TIMER_RESOLUTION = 0x1025;
const CL_DEVICE_ENDIAN_LITTLE = 0x1026;
const CL_DEVICE_AVAILABLE = 0x1027;
const CL_DEVICE_COMPILER_AVAILABLE = 0x1028;
const CL_DEVICE_EXECUTION_CAPABILITIES = 0x1029;
//const CL_DEVICE_QUEUE_PROPERTIES                      = 0x102A    /* deprecated */

const CL_DEVICE_QUEUE_ON_HOST_PROPERTIES = 0x102A; //cl2.0

const CL_DEVICE_NAME = 0x102B;
const CL_DEVICE_VENDOR = 0x102C;
const CL_DRIVER_VERSION = 0x102D;
const CL_DEVICE_PROFILE = 0x102E;
const CL_DEVICE_VERSION = 0x102F;
const CL_DEVICE_EXTENSIONS = 0x1030;
const CL_DEVICE_PLATFORM = 0x1031;

const CL_DEVICE_DOUBLE_FP_CONFIG = 0x1032;

/* 0x1033 reserved for CL_DEVICE_HALF_FP_CONFIG which is already defined in "cl_ext.h" */
//cl1.1

const CL_DEVICE_PREFERRED_VECTOR_WIDTH_HALF = 0x1034;
//const CL_DEVICE_HOST_UNIFIED_MEMORY                   = 0x1035   /* deprecated */
const CL_DEVICE_NATIVE_VECTOR_WIDTH_CHAR = 0x1036;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_SHORT = 0x1037;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_INT = 0x1038;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_LONG = 0x1039;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_FLOAT = 0x103A;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_DOUBLE = 0x103B;
const CL_DEVICE_NATIVE_VECTOR_WIDTH_HALF = 0x103C;
const CL_DEVICE_OPENCL_C_VERSION = 0x103D;

//cl1.2

const CL_DEVICE_LINKER_AVAILABLE = 0x103E;
const CL_DEVICE_BUILT_IN_KERNELS = 0x103F;
const CL_DEVICE_IMAGE_MAX_BUFFER_SIZE = 0x1040;
const CL_DEVICE_IMAGE_MAX_ARRAY_SIZE = 0x1041;
const CL_DEVICE_PARENT_DEVICE = 0x1042;
const CL_DEVICE_PARTITION_MAX_SUB_DEVICES = 0x1043;
const CL_DEVICE_PARTITION_PROPERTIES = 0x1044;
const CL_DEVICE_PARTITION_AFFINITY_DOMAIN = 0x1045;
const CL_DEVICE_PARTITION_TYPE = 0x1046;
const CL_DEVICE_REFERENCE_COUNT = 0x1047;
const CL_DEVICE_PREFERRED_INTEROP_USER_SYNC = 0x1048;
const CL_DEVICE_PRINTF_BUFFER_SIZE = 0x1049;

//cl2.0;

const CL_DEVICE_IMAGE_PITCH_ALIGNMENT = 0x104A;
const CL_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT = 0x104B;
const CL_DEVICE_MAX_READ_WRITE_IMAGE_ARGS = 0x104C;
const CL_DEVICE_MAX_GLOBAL_VARIABLE_SIZE = 0x104D;
const CL_DEVICE_QUEUE_ON_DEVICE_PROPERTIES = 0x104E;
const CL_DEVICE_QUEUE_ON_DEVICE_PREFERRED_SIZE = 0x104F;
const CL_DEVICE_QUEUE_ON_DEVICE_MAX_SIZE = 0x1050;
const CL_DEVICE_MAX_ON_DEVICE_QUEUES = 0x1051;
const CL_DEVICE_MAX_ON_DEVICE_EVENTS = 0x1052;
const CL_DEVICE_SVM_CAPABILITIES = 0x1053;
const CL_DEVICE_GLOBAL_VARIABLE_PREFERRED_TOTAL_SIZE = 0x1054;
const CL_DEVICE_MAX_PIPE_ARGS = 0x1055;
const CL_DEVICE_PIPE_MAX_ACTIVE_RESERVATIONS = 0x1056;
const CL_DEVICE_PIPE_MAX_PACKET_SIZE = 0x1057;
const CL_DEVICE_PREFERRED_PLATFORM_ATOMIC_ALIGNMENT = 0x1058;
const CL_DEVICE_PREFERRED_GLOBAL_ATOMIC_ALIGNMENT = 0x1059;
const CL_DEVICE_PREFERRED_LOCAL_ATOMIC_ALIGNMENT = 0x105A;

//cl2.1

const CL_DEVICE_IL_VERSION = 0x105B;
const CL_DEVICE_MAX_NUM_SUB_GROUPS = 0x105C;
const CL_DEVICE_SUB_GROUP_INDEPENDENT_FORWARD_PROGRESS = 0x105D;

//cl3.0
const CL_DEVICE_NUMERIC_VERSION = 0x105E;
const CL_DEVICE_EXTENSIONS_WITH_VERSION = 0x1060;
const CL_DEVICE_ILS_WITH_VERSION = 0x1061;
const CL_DEVICE_BUILT_IN_KERNELS_WITH_VERSION = 0x1062;
const CL_DEVICE_ATOMIC_MEMORY_CAPABILITIES = 0x1063;
const CL_DEVICE_ATOMIC_FENCE_CAPABILITIES = 0x1064;
const CL_DEVICE_NON_UNIFORM_WORK_GROUP_SUPPORT = 0x1065;
const CL_DEVICE_OPENCL_C_ALL_VERSIONS = 0x1066;
const CL_DEVICE_PREFERRED_WORK_GROUP_SIZE_MULTIPLE = 0x1067;
const CL_DEVICE_WORK_GROUP_COLLECTIVE_FUNCTIONS_SUPPORT = 0x1068;
const CL_DEVICE_GENERIC_ADDRESS_SPACE_SUPPORT = 0x1069;
/* 0x106A to 0x106E - Reserved for upcoming KHR extension */
const CL_DEVICE_OPENCL_C_FEATURES = 0x106F;
const CL_DEVICE_DEVICE_ENQUEUE_CAPABILITIES = 0x1070;
const CL_DEVICE_PIPE_SUPPORT = 0x1071;
const CL_DEVICE_LATEST_CONFORMANCE_VERSION_PASSED = 0x1072;

const CL_FP_DENORM = (1 << 0);
const CL_FP_INF_NAN = (1 << 1);
const CL_FP_ROUND_TO_NEAREST = (1 << 2);
const CL_FP_ROUND_TO_ZERO = (1 << 3);
const CL_FP_ROUND_TO_INF = (1 << 4);
const CL_FP_FMA = (1 << 5);

const CL_FP_SOFT_FLOAT = (1 << 6);

const CL_FP_CORRECTLY_ROUNDED_DIVIDE_SQRT = (1 << 7);

/* cl_mem_flags and cl_svm_mem_flags - bitfield */
const CL_MEM_READ_WRITE = (1 << 0);
const CL_MEM_WRITE_ONLY = (1 << 1);
const CL_MEM_READ_ONLY = (1 << 2);
const CL_MEM_USE_HOST_PTR = (1 << 3);
const CL_MEM_ALLOC_HOST_PTR = (1 << 4);
const CL_MEM_COPY_HOST_PTR = (1 << 5);
/* reserved                                        (1 << 6)    */
// CL_VERSION_1_2
const CL_MEM_HOST_WRITE_ONLY = (1 << 7);
const CL_MEM_HOST_READ_ONLY = (1 << 8);
const CL_MEM_HOST_NO_ACCESS = (1 << 9);

//CL_VERSION_2_0
const CL_MEM_SVM_FINE_GRAIN_BUFFER =
    (1 << 10); /* used by cl_svm_mem_flags only */
const CL_MEM_SVM_ATOMICS = (1 << 11); /* used by cl_svm_mem_flags only */
const CL_MEM_KERNEL_READ_AND_WRITE = (1 << 12);
