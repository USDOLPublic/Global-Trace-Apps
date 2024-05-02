import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppOrientation {
  static void setPreferredOrientationLandscape() {
    DeviceOrientation deviceOrientation;
    Platform.isAndroid
        ? deviceOrientation = DeviceOrientation.landscapeLeft
        : deviceOrientation = DeviceOrientation.landscapeRight;
    SystemChrome.setPreferredOrientations([deviceOrientation]);
  }

  static void setPreferredOrientationPortrait() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  static void setAllPreferredOrientation() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  static void setFullScreenApp() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  static void setFullScreenEnableSystemUIApp() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ) // Or Brightness.dart
        );
  }
}
