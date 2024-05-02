import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class LogTransformDetailsWidget extends StatelessWidget {
  const LogTransformDetailsWidget({
    super.key,
    required this.history,
  });
  final HistoryModel history;

  @override
  Widget build(BuildContext context) {
    List<TransformationItem>? transformationItems =
        history.transformation?.transformationItems;
    List<Widget> productsInfo = <Widget>[];
    transformationItems?.forEach(
      (element) {
        String weightValue =
            element.getWeightValue()?.toNumericFormat() ?? '-';
        String weightUnit =
            element.getWeightUnit() ?? defaultWeightUnit.displayLabel;
        String? productId = element.getProductIdOrQrCode();
        String? dnaIdentifier = element.getDNA();
        if (productId != null && productId.isNotEmpty) {
          productsInfo.add(
            _buildLineInfo(context, productId),
          );
        }
        if (dnaIdentifier != null && dnaIdentifier.isNotEmpty) {
          productsInfo.add(
            _buildLineInfo(context, dnaIdentifier),
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
