import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class LogSaleDetailsWidget extends StatelessWidget {
  const LogSaleDetailsWidget({
    super.key,
    required this.history,
  });
  final HistoryModel history;

  @override
  Widget build(BuildContext context) {
    List<TransactionItem>? transactionItems =
        history.transaction?.transactionItems;
    List<Widget> productsInfo = <Widget>[];
    transactionItems?.forEach(
      (element) {
        String weightValue =
            element.getWeightValue()?.toNumericFormat() ?? '-';
        String weightUnit =
            element.getWeightUnit() ?? defaultWeightUnit.displayLabel;
        String? productId = element.getProductIdOrQrCode();
        if (productId != null && productId.isNotEmpty) {
          productsInfo.add(
            _buildLineInfo(context, productId),
          );
        }
        productsInfo.add(
          _buildLineInfo(context, "$weightValue $weightUnit"),
        );
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: productsInfo,
    );
  }

  Widget _buildLineInfo(BuildContext context, String label) {
    return Text(
      label,
      style: AppTextStyles.bodyBold().copyWith(color: AppColors.grey600),
    );
  }
}
