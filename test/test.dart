import 'package:opencl/opencl.dart';
import 'dart:developer';

// To use simply pass your object to it

void main() {
  final OpenCL cl = OpenCL();
  List<Platform> platforms = cl.getPlatforms();
  platforms.forEach((platform) {
    print("Platform ${platform.name}:");
    print(platform.vendor);
    print(platform.version);
    print(platform.profile);
    print(platform.extensions);
    print(platform.hostTimerResolution);
    platform.devices.forEach((device) {
      print("Device ${device.name}");
      print("Maximum compute units: ${device.maxComputeUnits}");
      print(device.profile);
      print(device.type);
      print(device.vendor);
      print(device.extensions);
      print(device.toJson());
      var timer = device.getDeviceAndHostTimer();
      print(timer.deviceTimeStamp);
      print(timer.hostTimeStamp);
    });
  });
}
