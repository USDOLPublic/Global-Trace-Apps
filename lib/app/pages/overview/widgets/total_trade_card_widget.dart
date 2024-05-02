import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class TotalTradeCardWidget extends StatelessWidget {
  const TotalTradeCardWidget({
    super.key,
    required this.title,
    this.quantityUnit,
    this.chartValue,
  });

  final String title;
  final ChartValue? chartValue;
  final String? quantityUnit;

  @override
  Widget build(BuildContext context) {
    String valueDisplay = '-';
    if (chartValue?.value != null && chartValue!.isCanCalculate) {
      int valueInNumeric = chartValue!.value!.floor();
      valueDisplay = valueInNumeric.toString().toNumericFormat();
    }
    return OverviewCard(
      title: title,
      child: SizedBox(
        width: double.infinity,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: valueDisplay,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 28,
              color: AppColors.grey600,
            ),
            children: [
              TextSpan(
                text: " ${quantityUnit ?? defaultWeightUnit.displayLabel}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.grey600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
