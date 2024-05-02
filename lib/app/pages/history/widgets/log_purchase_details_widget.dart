import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class LogPurchaseDetailsWidget extends StatelessWidget {
  const LogPurchaseDetailsWidget({
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
        productsInfo.addAll(_buildProductInfo(context, element));
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: productsInfo,
    );
  }

  List<Widget> _buildProductInfo(BuildContext context, TransactionItem item) {
    List<Widget> productsInfo = <Widget>[];
    String? productIdOrQrCode = item.getProductIdOrQrCode();
    String weightValue = item.getWeightValue()?.toNumericFormat() ?? '-';
    String weightUnit = item.getWeightUnit() ?? defaultWeightUnit.displayLabel;
    String verifiedPercentage = (item.getVerified()?.toStringNoZero) ?? '-';
    String trashContent = item.getTrashContent() ?? '-';
    String moisture = (item.getMoisture() ?? 0).toStringNoZero;

    if (productIdOrQrCode != null && productIdOrQrCode.isNotEmpty) {
      productsInfo.add(
        _buildLineInfo(context, productIdOrQrCode),
      );
    }
    productsInfo.add(
      _buildLineInfo(context, "$weightValue $weightUnit"),
    );
    productsInfo.add(
      _buildLineInfo(
        context,
        "$trashContent, $moisture$percentSymbols",
      ),
    );
    productsInfo.add(
      _buildLineInfo(
        context,
        "$verifiedPercentage$percentSymbols ${S.of(context).verified}",
      ),
    );
    return productsInfo;
  }

  Widget _buildLineInfo(BuildContext context, String label) {
    return Text(
      label,
      style: AppTextStyles.bodyBold().copyWith(color: AppColors.grey600),
    );
  }
}
