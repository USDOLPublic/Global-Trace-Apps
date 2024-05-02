import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class HistoryEmptyView extends StatelessWidget {
  const HistoryEmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: AppProperties.contentMargin),
          Image.asset(
            AssetsConst.icEmptyPage,
            width: Get.width * .7,
          ),
          const SizedBox(height: 40),
          Text(
            S.of(context).noTransactionsMessage,
            style: const TextStyle(
              color: AppColors.grey200,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: AppProperties.contentMargin),
        ],
      ),
    );
  }
}
