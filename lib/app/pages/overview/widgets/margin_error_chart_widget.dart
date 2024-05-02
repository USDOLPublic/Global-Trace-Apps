import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class MarginErrorChartWidget extends StatelessWidget {
  const MarginErrorChartWidget({
    super.key,
    this.marginErrorData,
  });

  final MarginErrorChartResp? marginErrorData;

  @override
  Widget build(BuildContext context) {
    String marginDisplay = '-';
    bool isNotCalculated = !(marginErrorData?.isCanCalculate ?? true);
    if (marginErrorData?.value != null && !isNotCalculated) {
      double marginError = marginErrorData!.value!;
      marginError = marginError.abs();
      marginDisplay = marginError.floor().toString();
    }
    return OverviewCard(
      title: S.of(context).marginOfError,
      topLeftIcon: isNotCalculated
          ? null
          : const Icon(
              Icons.warning_rounded,
              color: AppColors.red,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: marginDisplay,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: isNotCalculated ? AppColors.grey600 : AppColors.red,
                ),
                children: [
                  TextSpan(
                    text: " $percentSymbols",
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
          if (isNotCalculated) _buildErrorChart(context),
        ],
      ),
    );
  }

  Widget _buildErrorChart(BuildContext context) {
    return Text(
      S.of(context).productQuantitiesCantCalculatedMarginError,
      style: AppTextStyles.bodyRegular().copyWith(
        color: AppColors.red,
      ),
    );
  }
}
