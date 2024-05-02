import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:usdol/app/core.dart';

class SaveFileToDownload {
  static Future<PermissionStatus> _requestWrireExternalStorage(BuildContext context) async {
    var status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      return PermissionStatus.granted;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await Get.dialog<void>(
        BasePopup(
          title: Text(
            S.of(context).unableToAccessStorage,
            style: const TextStyle(fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
          body: Text(S.of(context).storageAccessDenied),
          actions: [
            TextButton(
              onPressed: () async {
                Get.back<void>();
                await openAppSettings();
              },
              child: Text(S.of(context).ok),
            ),
          ],
        ),
      );
      return PermissionStatus.permanentlyDenied;
    }
    return status;
  }

  static Future<String> saveFile({
    required BuildContext context,
    required List<int> fileBytes,
    required String fileName,
  }) async {
    var status = await _requestWrireExternalStorage(context);
    if (status == PermissionStatus.permanentlyDenied) {
      status = await _requestWrireExternalStorage(context);
    }
    if (status == PermissionStatus.granted) {
      String dirPath = "";
      if (Platform.isAndroid) {
        Directory? dir = (await getExternalStorageDirectory());
        dirPath = dir?.path ?? "";
      } else if (Platform.isIOS) {
        dirPath = (await getApplicationDocumentsDirectory()).path;
      }
      LogUtil.d("Download dir:" + dirPath);
      if (dirPath.isNotEmpty) {
        String savePath = dirPath + "/$fileName";
        File fileData = File(savePath);
        if (await fileData.exists()) {
          await fileData.delete();
        }
        fileData = await fileData.writeAsBytes(fileBytes);
        return fileData.path;
      }
    }
    return "";
  }
}
