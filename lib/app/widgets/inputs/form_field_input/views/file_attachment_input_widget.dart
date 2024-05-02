import 'package:flutter/material.dart';
import 'package:usdol/app/core.dart';

class FileAttachmentInputWidget extends GetView<FileAttachmentInputController> {
  const FileAttachmentInputWidget({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  String? get tag => id;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<String> fileList = controller.filesPathSelected;
        return UploadFileInput(
          key: ValueKey('file-attachment-input-$id'),
          title: controller.getTitle(),
          filesSelected: fileList,
          onAddedNewFile: controller.pickFile,
          onRemovedFile: controller.removeFile,
        );
      },
    );
  }
}
