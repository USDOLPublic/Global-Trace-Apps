import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:usdol/app/core.dart';

class CircleChartWidget extends StatelessWidget {
  const CircleChartWidget({
    super.key,
    required this.radiusSize,
    required this.percentValue,
  });

  final double radiusSize;
  final double percentValue;

  @override
  Widget build(BuildContext context) {
    return _buildCircleChart(
      context,
      value: percentValue,
      indicatorColor: AppColors.green700,
      remainingColor: AppColors.orange700,
      radius: radiusSize / 2 - 8,
      noTrade: percentValue <= 0,
    );
  }

  Widget _buildCircleChart(
    BuildContext context, {
    required double value,
    required Color indicatorColor,
    required Color remainingColor,
    double radius = 60.0,
    double lineWidth = 8.0,
    bool noTrade = false,
  }) {
    double offset = 0.04;
    double spaceOffset = 0.0;
    double mainValue = value / 100.0;
    double remainValue = 1 - mainValue;
    if (mainValue > offset && remainValue > 0) {
      mainValue -= offset;
      spaceOffset += offset;
    }
    if (remainValue > offset && mainValue > 0) {
      remainValue -= offset;
      spaceOffset += offset;
    }
    double startAngleRemaining = 360 * (mainValue + spaceOffset / 2);
    if (noTrade) {
      return CircularPercentIndicator(
        radius: radius,
        lineWidth: lineWidth,
        percent: 0,
        progressColor: indicatorColor,
        animation: true,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: AppColors.grey100,
      );
    }
    return Stack(
      children: [
        CircularPercentIndicator(
          radius: radius,
          lineWidth: lineWidth,
          percent: mainValue,
          progressColor: indicatorColor,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.transparent,
        ),
        CircularPercentIndicator(
          radius: radius,
          startAngle: startAngleRemaining,
          lineWidth: lineWidth,
          percent: remainValue,
          progressColor: remainingColor,
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}
