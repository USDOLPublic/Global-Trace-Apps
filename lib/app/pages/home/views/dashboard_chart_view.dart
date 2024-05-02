import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class DashboardChartView extends GetView<HomeProductController> {
  const DashboardChartView({Key? key}) : super(key: key);

  void _viewAllOnClicked() {
    Get.toNamed<dynamic>(Routes.overview);
  }

  @override
  Widget build(BuildContext context) {
    return _buildDashboardChart(context);
  }

  Widget _buildDashboardChart(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppProperties.contentMargin,
      ),
      child: Column(
        children: [
          Obx(
            () => controller.isShowCycleChart
                ? const TimeFilterWidget(tagId: 'home')
                : const SizedBox.shrink(),
          ),
          Obx(
            () => controller.isShowCycleChart
                ? const MassBalanceOverviewView(tagId: 'home')
                : const SizedBox.shrink(),
          ),
          if (controller.isHavePermissionViewHistory()) ...[
            _buildTrackHistory(context),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _viewAllOnClicked,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        S.of(context).viewAll,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_right_rounded),
                  ],
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrackHistory(BuildContext context) {
    return Obx(() {
      if (controller.histories.isEmpty) {
        return const SizedBox.shrink();
      } else {
        List<HistoryModel> histories = controller.histories.take(2).toList();
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).latestTrade),
              ListView.builder(
                  itemCount: histories.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String valueTrade = "";
                    String traderName = "";
                    String mixText = "";

                    traderName = histories[index].getTradeName();
                    HistoryTransaction? transaction =
                        histories[index].transaction;
                    if (histories[index].type == TransactionType.sale) {
                      valueTrade = transaction?.getPriceInfo() ?? '-';
                      mixText = S.of(context).tradeToLabel;
                    } else {
                      valueTrade = transaction?.getTotalWeightInfo() ?? '-';
                      mixText = S.of(context).tradeFromLabel;
                    }
                    return _buildLineTrade(
                      context,
                      tradeDate: histories[index].getTradeDate(),
                      tradeQuality: valueTrade,
                      trader: traderName,
                      tradeMixText: mixText,
                    );
                  }),
            ],
          ),
        );
      }
    });
  }

  Widget _buildLineTrade(
    BuildContext context, {
    String tradeQuality = "",
    String trader = "",
    String tradeMixText = "",
    DateTime? tradeDate,
  }) {
    TextStyle boldStyle =
        const TextStyle(color: AppColors.grey600, fontWeight: FontWeight.w600);
    TextStyle normalStyle =
        const TextStyle(color: AppColors.grey600, fontWeight: FontWeight.w400);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: tradeQuality,
          style: boldStyle,
          children: [
            TextSpan(
              text: tradeMixText,
              style: normalStyle,
            ),
            TextSpan(
              text: "$trader, ",
              style: boldStyle,
            ),
            TextSpan(
              text: tradeDate == null
                  ? ""
                  : DateUtil.parseFromDateTime(tradeDate, 'd MMM yyyy'),
              style: boldStyle,
            ),
          ],
        ),
      ),
    );
  }
}
