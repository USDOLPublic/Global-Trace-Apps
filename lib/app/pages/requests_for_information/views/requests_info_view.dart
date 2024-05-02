import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:usdol/app/core.dart';

class RequestsInfoView extends GetView<RequestsInfoController> {
  const RequestsInfoView({Key? key}) : super(key: key);

  void _requestItemOnClicked(RequestInformationModel requestInfo) async {
    await Get.toNamed<void>(Routes.detailsRequestsInfo, arguments: requestInfo);
    controller.refreshData();
  }

  void _onLoading() {
    controller.loadMoreRequestForInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: S.of(context).requestHome,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppProperties.contentMargin,
          AppProperties.contentMargin,
          AppProperties.contentMargin,
          0,
        ),
        child: Obx(() {
          return controller.requestInformation.isEmpty
              ? EmptyPage(
                  text: S.of(context).noRequestInformation,
                )
              : SmartRefresher(
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
                      }
                      return SizedBox(
                        height: 95.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: controller.refreshController,
                  onLoading: () {
                    _onLoading();
                  },
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return _buildRequestInfoItem(
                          context, controller.requestInformation[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 16);
                    },
                    itemCount: controller.requestInformation.length,
                  ),
                );
        }),
      ),
    );
  }

  Widget _buildRequestInfoItem(
      BuildContext context, RequestInformationModel requestInfo) {
    TextStyle titleStyle = const TextStyle(
      color: AppColors.grey700,
      fontWeight: FontWeight.w600,
    );
    TextStyle dateTimeStyle = const TextStyle(
      color: AppColors.grey700,
      fontWeight: FontWeight.w600,
    );

    final date = requestInfo.getTimeDisplay();
    final displayDate =
        DateUtil.formatDate(date, format: AppProperties.dateFormatDefault);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            displayDate,
            style: dateTimeStyle,
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          key: const ValueKey('requestInfo'),
          onTap: () => _requestItemOnClicked(requestInfo),
          borderRadius: BorderRadius.circular(AppProperties.circleRadius),
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          requestInfo.getFacilityName,
                          style: titleStyle,
                        ),
                      ),
                      Text(
                        ReportStatusEnum.getReportStatus(
                            requestInfo.status ?? -1, context),
                        style: titleStyle.apply(color: AppColors.green800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _listLaborRisksRespWidget(context, requestInfo.laborRisks)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _listLaborRisksRespWidget(
    BuildContext context,
    List<LaborRisksResp>? laborRisks,
  ) {
    if (laborRisks == null) {
      return const SizedBox.shrink();
    }
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return _laborRiskRespWidget(context, laborRisks[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 8,
      ),
      itemCount: laborRisks.length,
      padding: EdgeInsets.zero,
    );
  }

  Widget _laborRiskRespWidget(
    BuildContext context,
    LaborRisksResp laborRisksResp,
  ) {
    SeverityModel? severity = listSeverityDef.firstWhereOrNull(
      (element) => element.value == laborRisksResp.severity,
    );
    if (severity == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(severity.color ?? 0xFFFFFFFF),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                laborRisksResp.indicator?.name ?? "",
                style: const TextStyle(
                  color: AppColors.grey700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          laborRisksResp.subIndicator?.name ?? "",
          style: const TextStyle(
            color: AppColors.grey600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
