import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:usdol/app/core.dart';

class FileListDialog extends StatelessWidget {
  FileListDialog({
    Key? key,
    required this.files,
    required this.onDownloadFile,
  }) : super(key: key);

  final List<FileAttachmentModel> files;
  final Future<List<int>?> Function(String) onDownloadFile;

  final _listDownloading = <String>[].obs;
  // ignore: invalid_use_of_protected_member
  List<String> get listDownloading => _listDownloading.value;

  void _openFile(BuildContext context, FileAttachmentModel file) async {
    String link = file.link ?? '';
    String fileName = file.fileName ?? '';
    String localPath = await FileUtil.getFilePath(fileName);
    if (localPath.isEmpty) {
      _listDownloading.add(link);
      _listDownloading.refresh();
      List<int>? byteData = await onDownloadFile(
        link,
      );
      if (byteData != null) {
        File file = await FileUtil.writeFileToStorage(byteData, fileName);
        localPath = file.path;
      }
      _listDownloading.remove(link);
      _listDownloading.refresh();
    }
    if (localPath.isNotEmpty) {
      await OpenFilex.open(localPath);
    } else {
      LogUtil.e("File error. can't open");
      SnackBars.error(message: S.of(context).fileInvalid).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePopup(
      title: Text(S.of(context).fileAndAttachment),
      body: SizedBox(
        height: Get.height * .35,
        child: files.isEmpty
            ? Center(
                child: Text(S.of(context).haveNoFileForDownload),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Obx(
                  () {
                    var dowloadings = listDownloading;
                    return ListView.separated(
                      itemCount: files.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        String path = files[index].link ?? '';
                        return _buildItemFile(
                          context,
                          files[index],
                          dowloadings.contains(path),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    );
                  },
                ),
              ),
      ),
      isSmallAlert: false,
      actions: [
        TextButton(
          key: const ValueKey("acceptedBtn"),
          onPressed: () async {
            Get.back<void>();
          },
          child: Text(S.current.done),
        ),
      ],
    );
  }

  Widget _buildItemFile(
      BuildContext context, FileAttachmentModel file, bool isDownloading) {
    return InkWell(
      onTap: () => _openFile(context, file),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 64,
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: isDownloading
                  ? const CircularProgressIndicator()
                  : Icon((file.fileName ?? '').isImage()
                      ? Icons.image
                      : Icons.picture_as_pdf_outlined),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  file.fileName ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
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
