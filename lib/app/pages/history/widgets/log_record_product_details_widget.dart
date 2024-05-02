import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class LogRecordProductDetailsWidget extends StatelessWidget {
  const LogRecordProductDetailsWidget({
    super.key,
    required this.history,
  });
  final HistoryModel history;

  @override
  Widget build(BuildContext context) {
    HistoryRecordProduct? recordProduct = history.recordProduct;
    String weightValue = (recordProduct?.totalWeight?.toNumericFormat()) ?? '-';
    String weightUnit = (recordProduct?.weightUnit) ?? '-';
    return Text(
      "$weightValue $weightUnit",
      style: AppTextStyles.bodyBold().copyWith(color: AppColors.grey600),
    );
  }
}
