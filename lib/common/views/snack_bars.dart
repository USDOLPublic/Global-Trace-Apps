import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usdol/app/core.dart';

class SnackBars {
  String? title;
  String message = "";
  FlushbarPosition? position = FlushbarPosition.BOTTOM;
  IconData? icon;
  Color? iconColor = Colors.green;
  Color? indicatorColor = Colors.green;

  static final List<Flushbar> _activeNotices = <Flushbar>[];

  static SnackBars info({required String message, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
      message: message,
      position: position,
      icon: Icons.info_outline,
      iconColor: Colors.grey[600],
      indicatorColor: Colors.grey[600],
    );
  }

  static SnackBars error({required String message, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
      message: message,
      position: position,
      icon: Icons.error_outline_rounded,
      iconColor: Colors.red,
      indicatorColor: Colors.red,
    );
  }

  static SnackBars complete({required String message, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
      message: message,
      position: position,
      icon: Icons.check_circle_outline_rounded,
      iconColor: Colors.green,
      indicatorColor: Colors.green,
    );
  }

  static SnackBars warning({required String message, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
      message: message,
      position: position,
      icon: Icons.warning_rounded,
      iconColor: Colors.orange[300],
      indicatorColor: Colors.orange[300],
    );
  }

  static SnackBars notice({required String message, String? title, FlushbarPosition position = FlushbarPosition.TOP}) {
    return SnackBars(
        title: title ?? "",
        message: message,
        position: position,
        icon: Icons.notifications_active_rounded,
        iconColor: Colors.green[300],
        indicatorColor: Colors.green[300]);
  }

  SnackBars({this.icon, this.iconColor, this.indicatorColor, required this.message, this.title, this.position});

  void show({int duration = 3000, BuildContext? context}) {
    Flushbar flushbar = Flushbar<void>(
      message: message,
      title: title,
      icon: Icon(
        icon,
        size: 28.0,
        color: iconColor,
      ),
      duration: Duration(milliseconds: duration),
      animationDuration: const Duration(milliseconds: 700),
      //leftBarIndicatorColor: indicatorColor,
      flushbarPosition: position ?? FlushbarPosition.BOTTOM,
      borderRadius: BorderRadius.circular(30),
      margin: const EdgeInsets.all(8),
    );
    flushbar.show(context ?? Get.context!);
    _activeNotices.add(flushbar);
  }

  static bool hasActiveNotifications() {
    for (Flushbar<dynamic> noti in _activeNotices) {
      if (noti.isAppearing() || noti.isHiding() || noti.isShowing()) {
        return true;
      }
    }
    return false;
  }

  static void removeDimissedNotifications() {
    _activeNotices.removeWhere((element) => element.isDismissed());
  }

  static void dismissAll() {
    removeDimissedNotifications();
    for (Flushbar<dynamic> noti in _activeNotices) {
      noti.dismiss();
    }
  }
}
