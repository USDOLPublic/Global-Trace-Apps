import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class VersionUtil {
  Future<bool> isAboveAndroid32() async {
    bool isAboveAndroidVer32 = false;
    if (Platform.isAndroid) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      isAboveAndroidVer32 = deviceInfo.version.sdkInt > 32;
    }
    return isAboveAndroidVer32;
  }
}
