import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class MassBalanceOverviewView extends GetView<OverviewController> {
  const MassBalanceOverviewView({
    super.key,
    this.tagId,
  });

  final String? tagId;

  @override
  String? get tag => tagId;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MassBalanceChartWidget(
        massBalanceData: controller.calMassBalanceChart,
      ),
    );
  }
}
