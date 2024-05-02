import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:usdol/app/core.dart';

class OverviewView extends GetView<OverviewController> {
  const OverviewView({super.key});

  void _onLoading(BuildContext context) {
    controller.loadMoreHistory();
  }

  void _syncHistoryOnClicked() {
    controller.syncPendingRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).overview,
        hasCloseButton: true,
        closeWidget: Obx(
          () => controller.isHistorySyncing
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                )
              : const Icon(Icons.sync, color: AppColors.green700),
        ),
        onClose: _syncHistoryOnClicked,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppProperties.contentMargin),
        child: Column(
          children: [
            const TimeFilterWidget(),
            const SizedBox(
              height: AppProperties.lineSpace,
            ),
            Expanded(
              child: _buildBody(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body = const SizedBox.shrink();
          if (mode == LoadStatus.idle) {
            body = Text(S.of(context).pullUpLoad);
          } else if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text(S.of(context).loadFailedClick);
          } else if (mode == LoadStatus.canLoading) {
            body = Text(S.of(context).releaseToLoad);
          } else {
            body = Text(S.of(context).noMoreData);
          }
          return SizedBox(
            height: 95.0,
            child: Center(child: body),
          );
        },
      ),
      controller: controller.refreshController,
      onLoading: () {
        _onLoading(context);
      },
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _buildOverviewChart(context),
          const SizedBox(
            height: AppProperties.lineSpace,
          ),
          if (controller.isHavePermissionViewHistory())
            GetBuilder<HistoryController>(
              init: Get.isRegistered<HistoryController>()
                  ? Get.find<HistoryController>()
                  : Get.put(HistoryController()),
              // initState: (state) {
              //   controller.initHistory(state.controller);
              //},
              builder: (historyController) {
                controller.initHistory(historyController);
                return HistoryBuilderView(controller: historyController);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildOverviewChart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () {
            ChartValue? chartValue = controller.productTradeChart?.totalInputs;
            return TotalTradeCardWidget(
              title: S.of(context).totalInput,
              chartValue: chartValue,
            );
          },
        ),
        const SizedBox(
          height: AppProperties.lineSpace,
        ),
        Obx(
          () {
            ChartValue? chartValue =
                controller.productTradeChart?.totalByProduct;
            return TotalTradeCardWidget(
              title: S.of(context).byProduct,
              chartValue: chartValue,
            );
          },
        ),
        const SizedBox(
          height: AppProperties.lineSpace,
        ),
         Obx(
          () {
            ChartValue? chartValue = controller.productTradeChart?.totalOutputs;
            return TotalTradeCardWidget(
              title: S.of(context).totalOutput,
              chartValue: chartValue,
            );
          },
        ),
        const SizedBox(
          height: AppProperties.lineSpace,
        ),
        if (controller.userInfo.isMassBalance())
          OverviewCard(
            title: S.of(context).massBalance,
            child: Obx(
              () => MassBalanceChartWidget(
                massBalanceData: controller.calMassBalanceChart,
              ),
            ),
          ),
        if (controller.isHasPermissionViewErrorMargin()) ...[
          const SizedBox(
            height: AppProperties.lineSpace,
          ),
          Obx(
            () => MarginErrorChartWidget(
              marginErrorData: controller.calMarginErrorChart,
            ),
          ),
        ],
      ],
    );
  }
}
