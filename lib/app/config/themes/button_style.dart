import 'package:flutter/material.dart';
import 'package:usdol/app/constants/constants.dart';

class ElevatedBtnStyle {
  static ButtonStyle enable() {
    return ElevatedButton.styleFrom(backgroundColor: AppColors.green800);
  }

  static ButtonStyle disable() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.grey200,
      splashFactory: NoSplash.splashFactory,
    );
  }
}

class TextButtonBtnStyle {
  static ButtonStyle enable() {
    return TextButton.styleFrom(foregroundColor: AppColors.green800);
  }

  static ButtonStyle disable() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.grey200,
      splashFactory: NoSplash.splashFactory,
    );
  }
}

class TextIconButtonBtnStyle {
  static ButtonStyle enable() {
    return TextButton.styleFrom(foregroundColor: AppColors.orange700);
  }

  static ButtonStyle disable() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.grey200,
      splashFactory: NoSplash.splashFactory,
    );
  }
}
