import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  static bool _isPausedApp = false;
  LifecycleEventHandler();

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    LogUtil.d("[Lifecycle] ${state.toString()}");
    switch (state) {
      case AppLifecycleState.resumed:
        if (_isPausedApp) {
          //Resume app from background
          
        }
        _isPausedApp = false;
        break;
      case AppLifecycleState.paused:
        _isPausedApp = true;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
