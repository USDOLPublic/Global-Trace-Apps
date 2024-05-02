import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:usdol/app/core.dart';

class ScannerController extends GetxController {
  late QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final _isCameraPermissionGranted = false.obs;
  bool get isCameraPermissionGranted => _isCameraPermissionGranted.value;
  set isCameraPermissionGranted(bool value) =>
      _isCameraPermissionGranted.value = value;

  final _isCameraBack = false.obs;
  bool get isCameraBack => _isCameraBack.value;
  set isCameraBack(bool value) => _isCameraBack.value = value;

  final _isEnableFlash = false.obs;
  bool get isEnableFlash => _isEnableFlash.value;
  set isEnableFlash(bool value) => _isEnableFlash.value = value;

  String _qrCodeScanned = "";
  bool isShowingAskPermission = false;

  String pageTitle = "";

  @override
  void onInit() {
    if (Get.arguments != null && Get.arguments is String) {
      pageTitle = Get.arguments as String;
    } else {
      pageTitle = '';
    }
    super.onInit();
  }

  @override
  void onClose() {
    qrController?.dispose();
    super.onClose();
  }

  void setQrCodeScan(QRViewController cont) {
    qrController = cont;
    if (Platform.isAndroid) {
      qrController?.resumeCamera();
    }

    qrController?.scannedDataStream.listen((scanData) async {
      if (scanData.code != null && _qrCodeScanned != scanData.code) {
        _qrCodeScanned = scanData.code ?? "";
        await qrController?.pauseCamera();
        //code
        Get.back(result: _qrCodeScanned);
      }
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      qrController?.getCameraInfo().then((value) {
        isCameraBack = (value == CameraFacing.back);
      });
      qrController?.getFlashStatus().then((value) {
        isEnableFlash = (value ?? false);
      });
    });
  }
}
