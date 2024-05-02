import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class MassBalanceChartWidget extends StatelessWidget {
  const MassBalanceChartWidget({
    super.key,
    required this.massBalanceData,
  });

  final MassBalanceChartResp? massBalanceData;

  @override
  Widget build(BuildContext context) {
    String quantityUnit =
        massBalanceData?.quantityUnit ?? defaultWeightUnit.displayLabel;
    double noOfTracked = massBalanceData?.verifiedQuantity ?? 0;
    double totalTrade =
        noOfTracked + (massBalanceData?.notVerifiedQuantity ?? 0);
    bool isNotCalculated = !(massBalanceData?.isCanCalculate ?? true);
    DateTime lastUpdate =
        massBalanceData?.getLastTimeUpdate() ?? DateTime.now();
    return _buildTrackChart(
      context,
      noOfTracked: noOfTracked,
      totalTrade: totalTrade,
      quantityUnit: quantityUnit,
      isNotCalculated: isNotCalculated,
      lastUpdate: lastUpdate,
    );
  }

  Widget _buildTrackChart(
    BuildContext context, {
    required double noOfTracked,
    required double totalTrade,
    required String quantityUnit,
    bool isNotCalculated = true,
    required DateTime lastUpdate,
  }) {
    double chartSize = Get.width * 0.3;
    double percentTracked = 0;
    String lastUpdateStr = "";
    String percentTrackedStr = percentSymbols;
    String percentNotTrackedStr = percentSymbols;
    lastUpdateStr = Jiffy.parseFromDateTime(lastUpdate)
        .format(pattern: "d MMM yyyy, hh:mm a");
    String verifiedSumup = S.of(context).verified + ":";
    //check case: tracked > total
    if (noOfTracked > totalTrade) {
      totalTrade = noOfTracked;
    }
    //calculator percent tracked
    if (totalTrade > 0 && noOfTracked > 0) {
      percentTracked = (noOfTracked / totalTrade) * 100.0;
    }
    String noOfTrackedStr = noOfTracked.toNumericFormat(fractionDigits: 0);
    String totalStr = totalTrade.toNumericFormat(fractionDigits: 0);

    verifiedSumup =
        S.of(context).verifiedSumup(noOfTrackedStr, "$totalStr $quantityUnit");
    if (totalTrade > 0) {
      percentTrackedStr = "${percentTracked.round()}$percentSymbols";
      percentNotTrackedStr = "${100 - percentTracked.round()}$percentSymbols";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: chartSize,
                height: chartSize,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Center(
                    child: CircleChartWidget(
                      radiusSize: chartSize,
                      percentValue: percentTracked,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildChartDescription(
                  context,
                  percentTrackedStr,
                  percentNotTrackedStr,
                  verifiedSumup,
                  lastUpdate,
                  lastUpdateStr,
                ),
              ),
            ],
          ),
          if (isNotCalculated) _buildErrorChart(context),
        ],
      ),
    );
  }

  Widget _buildErrorChart(BuildContext context) {
    return Text(
      S.of(context).productQuantitiesCantCalculatedMassBalance,
      style: AppTextStyles.bodyRegular().copyWith(
        color: AppColors.red,
      ),
    );
  }

  Widget _buildChartDescription(
    BuildContext context,
    String percentTrackedStr,
    String percentNotTrackedStr,
    String verifiedSumup,
    DateTime? lastUpdate,
    String lastUpdateStr,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDotDescription(
          context,
          color: AppColors.green700,
          title: S.of(context).verified,
          value: percentTrackedStr,
        ),
        _buildDotDescription(
          context,
          color: AppColors.orange700,
          title: S.of(context).notVerified,
          value: percentNotTrackedStr,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            verifiedSumup,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.grey300,
            ),
          ),
        ),
        if (lastUpdate != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              S.of(context).lasUpdateTime(lastUpdateStr),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.grey200,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDotDescription(
    BuildContext context, {
    String title = "",
    Color color = AppColors.green800,
    String value = "",
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.grey600,
            ),
          )),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.grey600,
            ),
          ),
        ],
      ),
    );
  }
}
