import 'package:flutter/cupertino.dart';
import '../../core.dart';

class AppTextStyles {
  static TextStyle lead() {
    return const TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: 32,
      color: AppColors.green800,
    );
  }

  static TextStyle bodyBold() {
    return const TextStyle(
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle bodyMedium() {
    return const TextStyle(
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle bodyRegular() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle title() {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: AppColors.green800,
    );
  }

  static TextStyle small() {
    return const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 10,
    );
  }

  static TextStyle tiny() {
    return const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 8,
    );
  }
}
