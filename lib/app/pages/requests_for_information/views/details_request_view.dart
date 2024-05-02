import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class DetailsRequestsView extends GetView<DetailRequestController> {
  const DetailsRequestsView({Key? key}) : super(key: key);

  Future<void> _respondToRequestOnClicked() async {
    controller.onTapResponseToRequest();
  }

  void _onTapRespondItem(int index) {
    controller.expandedIndex = index != controller.expandedIndex ? index : (-2);
  }

  void _viewFileOnClicked(
    BuildContext context,
    FileAttachmentModel fileAttach,
  ) {
    Get.dialog<void>(
      FileListDialog(
        files: [fileAttach],
        onDownloadFile: (path) async {
          return await controller.downloadFile(path);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: controller.requestInfo?.facility?.name ?? '',
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              List<Widget> requestWidgetItems = <Widget>[];
              if (controller.requestInfo != null) {
                // respond list
                if (controller.requestInfo!.responses != null &&
                    controller.requestInfo!.responses!.isNotEmpty) {
                  var responds = controller.requestInfo!.responses!;
                  for (var item in responds) {
                    requestWidgetItems.add(
                      _buildExpandedItem(
                        context,
                        response: item,
                        isExpanded:
                            responds.indexOf(item) == controller.expandedIndex,
                        onTap: () => _onTapRespondItem(responds.indexOf(item)),
                      ),
                    );
                  }
                }
                //request
                requestWidgetItems.add(
                  _buildExpandedItem(
                    context,
                    request: controller.requestInfo,
                    isExpanded: requestWidgetItems.isEmpty ||
                        controller.expandedIndex == -1,
                    onTap: () => _onTapRespondItem(-1),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(AppProperties.contentMargin),
                child: ListView.separated(
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return requestWidgetItems[index];
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12);
                  },
                  itemCount: requestWidgetItems.length,
                ),
              );
            }),
          ),
          Visibility(
            visible: controller.hasPermissionRespond(),
            child: Obx(
              () => BottomAction(
                key: const ValueKey('respondToRequest'),
                isEnableBtn: true,
                titleBtn: (controller.requestInfo?.haveResponse ?? false)
                    ? S.of(context).submitFurtherInformation
                    : S.of(context).respondToRequest,
                onPress: () => _respondToRequestOnClicked(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLineInfo(
    BuildContext context, {
    String label = "",
    String value = "",
    bool isHorizontal = false,
    bool isBold = false,
  }) {
    Widget labelWidget = Text(
      label,
      style: const TextStyle(
        color: AppColors.grey300,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );

    Widget valueWidget = Text(
      value,
      style: TextStyle(
        color: AppColors.grey700,
        fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
        fontSize: 14,
      ),
      textAlign: isHorizontal ? TextAlign.end : TextAlign.start,
    );

    if (isHorizontal) {
      return Row(
        children: [
          labelWidget,
          Expanded(child: valueWidget),
        ],
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelWidget,
            const SizedBox(height: 8),
            valueWidget,
          ],
        ),
      );
    }
  }

  Widget _buildExpandedItem(
    BuildContext context, {
    RequestInformationModel? request,
    RespondModel? response,
    bool isExpanded = false,
    Function? onTap,
  }) {
    DateTime? submissionAt = DateTime.now();
    if (request != null) {
      submissionAt = request.getTimeDisplay();
    }
    if (response != null && response.recordedAt != null) {
      submissionAt = response.getRecordedAt();
    }

    return Column(
      children: [
        GestureDetector(
          onTap: () => onTap?.call(),
          child: Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(AppProperties.contentMargin),
              child: _buildLineInfo(
                context,
                label: S.of(context).submission,
                value: DateUtil.parseFromDateTime(
                  submissionAt,
                  AppProperties.dateTimeFormatDefault,
                ),
                isHorizontal: true,
                isBold: true,
              ),
            ),
          ),
        ),
        Visibility(
          visible: isExpanded,
          child: Container(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(AppProperties.contentMargin, 0,
                  AppProperties.contentMargin, AppProperties.contentMargin),
              child: request != null
                  ? _buildRequestItem(context, request)
                  : response != null
                      ? _buildRespondItem(context, response)
                      : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestItem(
    BuildContext context,
    RequestInformationModel request,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLineInfo(
          context,
          label: S.of(context).status,
          value:
              ReportStatusEnum.getReportStatus(request.status ?? -1, context),
          isBold: true,
        ),
        const SizedBox(height: 12),
        Text(
          S.of(context).indicatorSub,
          style: const TextStyle(
            color: AppColors.grey300,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        _listLaborRisksRespWidget(
          context,
          request.laborRisks,
        ),
        const SizedBox(height: 12),
        _buildLineInfo(
          context,
          label: S.of(context).location,
          value: request.location ?? "",
        ),
        const SizedBox(height: 12),
        _buildLineInfo(
          context,
          label: S.of(context).notes,
          value: (request.message ?? ""),
        ),
      ],
    );
  }

  Widget _buildRespondItem(BuildContext context, RespondModel respond) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLineInfo(
          context,
          label: S.of(context).facility,
          value: controller.requestInfo?.getFacilityName ?? '',
        ),
        const SizedBox(height: 12),
        Text(
          S.of(context).indicatorSub,
          style: const TextStyle(
            color: AppColors.grey300,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 12),
        _listLaborRisksRespWidget(
          context,
          respond.laborRisks,
        ),
        const SizedBox(height: 12),
        _buildLineInfo(
          context,
          label: S.of(context).notes,
          value: (respond.message ?? ""),
        ),
        const Divider(height: 24),
        if (respond.uploadImages?.isNotEmpty ?? false)
          ...respond.uploadImages!.map(
            (path) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildItemFile(
                  context,
                  path,
                ),
              );
            },
          ).toList(),
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

  Widget _buildItemFile(BuildContext context, String path) {
    if (path.isEmpty) {
      return const SizedBox.shrink();
    }
    FileAttachmentModel fileAttachment = FileAttachmentModel(
      fileName: FileUtil.getFileNameByUrl(path, isSkipUUID: true),
      link: path,
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey200),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.08),
            spreadRadius: 20,
            blurRadius: 7,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _viewFileOnClicked(context, fileAttachment),
        child: Row(
          children: [
            Icon((fileAttachment.fileName ?? '').isImage()
                ? Icons.image
                : Icons.picture_as_pdf_outlined),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  fileAttachment.fileName ?? '',
                  style: const TextStyle(
                    color: AppColors.green700,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
