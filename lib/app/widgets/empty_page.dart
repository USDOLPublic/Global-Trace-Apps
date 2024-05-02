import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class EmptyPage extends StatelessWidget {
  final String? text;
  final EdgeInsets padding;

  const EmptyPage({
    Key? key,
    this.text,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetsConst.icEmptyPage,
            width: Get.width * .7,
          ),
          const SizedBox(height: 40),
          Text(
            text ?? '',
            style: const TextStyle(
              color: AppColors.grey200,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
