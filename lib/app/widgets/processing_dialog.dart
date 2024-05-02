import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class ProcessingDialog {
  ProcessingDialog();
  bool isShowing = false;

  void hide() {
    if (isShowing) {
      Get.back<void>();
    }
  }

  void show() {
    if (!isShowing) {
      isShowing = true;
      Get.dialog<void>(
        WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            contentPadding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppProperties.circleRadius),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: ThreeBounceLoading(),
            ),
          ),
        ),
        barrierDismissible: false,
      ).then((value) {
        isShowing = false;
      });
    }
  }

  factory ProcessingDialog.show() {
    ProcessingDialog dialog = ProcessingDialog();
    dialog.show();
    return dialog;
  }
}
