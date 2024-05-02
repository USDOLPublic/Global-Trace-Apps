import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class PasswordTooltip extends StatelessWidget {
  const PasswordTooltip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: S.of(context).passwordToolTips,
      triggerMode: TooltipTriggerMode.tap,
      preferBelow: false,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppProperties.circleRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.k4B4B45.withOpacity(0.04),
            spreadRadius: 10,
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      textStyle: const TextStyle(color: AppColors.grey600),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      showDuration: const Duration(milliseconds: 5000),
      child: const Icon(
        Icons.info_outline_rounded,
        color: AppColors.grey300,
      ),
    );
  }
}
