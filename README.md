<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
# OpenCL for Dart

This is a wrapper of the OpenCL library for the Dart programming language.

It is tailored toward desktop environments, currently tested only for linux.

Currently under development. WIP.

Implemented features: partial device & platform query.

## Features

It can query information about your computing platforms, such as your GPU.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
final OpenCL cl = OpenCL();
List<Platform> platforms = cl.getPlatforms();
```

## Additional information

Any help is welcomed!

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
