import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class HistoryBuilderView extends StatelessWidget {
  const HistoryBuilderView({super.key, required this.controller});
  final HistoryController controller;

  void _historyItemOnClicked(HistoryModel history) {
    Get.dialog<void>(
      FileListDialog(
        files: history.getCredentialFiles(),
        onDownloadFile: (path) async {
          return await controller.downloadFile(path);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.histories.isEmpty) {
        return const HistoryEmptyView();
      }
      return ListView.separated(
        itemCount: controller.histories.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return LogItemWidget(
            history: controller.histories[index],
            onAttachmentTap: _historyItemOnClicked,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
      );
    });
  }
}
