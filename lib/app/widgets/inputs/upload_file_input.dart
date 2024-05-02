import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:usdol/app/core.dart';

enum FilePickerMethod { takePhoto, chooseFromGallery, chooseFromFiles }

// ignore: must_be_immutable
class UploadFileInput extends StatelessWidget {
  UploadFileInput({
    Key? key,
    required this.title,
    required this.filesSelected,
    required this.onAddedNewFile,
    required this.onRemovedFile,
    this.isSinglePick = false,
    this.fileFormats = const ['pdf', 'jpg'],
  }) : super(key: key);

  final String title;
  final List<String> fileFormats;
  final List<String> filesSelected;
  final void Function(String)? onAddedNewFile;
  final void Function(String)? onRemovedFile;
  final ImagePicker _imagePicker = ImagePicker();
  final bool isSinglePick;
  bool _modalIsOpen = false;
  ProcessingDialog processingDialog = ProcessingDialog();

  Future<PermissionStatus> _checkCameraPermission(BuildContext context) async {
    var status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      return PermissionStatus.granted;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await Get.dialog<void>(
        BasePopup(
          title: Text(
            S.of(context).unableToAccessCamera,
            style: const TextStyle(fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
          body: Text(S.of(context).cameraAccessDenied),
          actions: [
            TextButton(
              onPressed: () async {
                Get.back<void>();
                await openAppSettings();
              },
              child: Text(S.of(context).ok),
            ),
          ],
        ),
      );
      return status;
    } else {
      return status;
    }
  }

  Future<PermissionStatus> _checkExternalStoragePermission(
    BuildContext context, {
    bool isImageType = false,
  }) async {
    PermissionStatus status;
    bool isAboveAndroid32 = await VersionUtil().isAboveAndroid32();
    if (isImageType) {
      if (Platform.isIOS || isAboveAndroid32) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }
    } else {
      if (Platform.isIOS || !isAboveAndroid32) {
        status = await Permission.storage.request();
      } else {
        status = PermissionStatus.granted;
      }
    }
    if (status == PermissionStatus.granted) {
      return PermissionStatus.granted;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await Get.dialog<void>(
        BasePopup(
          title: Text(
            S.of(context).unableToAccessStorage,
            style: const TextStyle(fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
          body: Text(S.of(context).storageAccessDenied),
          actions: [
            TextButton(
              onPressed: () async {
                Get.back<void>();
                await openAppSettings();
              },
              child: Text(S.of(context).ok),
            ),
          ],
        ),
      );
      return status;
    } else {
      return status;
    }
  }

  Future<void> _openChooosePickFileMethod(BuildContext context) async {
    //Hide keyboard
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => CupertinoActionSheet(
        title: Text(S.of(context).pickeFileUsing),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            key: const ValueKey('takePhoto'),
            child: Text(S.of(context).takePhoto),
            onPressed: () {
              Get.back<void>();
              _pickFileFrom(context, FilePickerMethod.takePhoto);
            },
          ),
          CupertinoActionSheetAction(
            key: const ValueKey('chooseFromGallery'),
            child: Text(S.of(context).chooseFromGallery),
            onPressed: () {
              Get.back<void>();
              _pickFileFrom(context, FilePickerMethod.chooseFromGallery);
            },
          ),
          CupertinoActionSheetAction(
            key: const ValueKey('chooseFromFileDirectory'),
            child: Text(S.of(context).chooseFromFileDirectory),
            onPressed: () {
              Get.back<void>();
              _pickFileFrom(context, FilePickerMethod.chooseFromFiles);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(S.of(context).cancel),
          onPressed: () {
            Get.back<void>();
          },
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> _pickFileFrom(
      BuildContext context, FilePickerMethod method) async {
    String pickPath = "";
    if (method == FilePickerMethod.chooseFromFiles) {
      var permission = await _checkExternalStoragePermission(context);
      if (permission == PermissionStatus.granted) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: fileFormats,
        );
        if (result != null && result.files.single.path != null) {
          pickPath = result.files.single.path ?? "";
        }
      }
    } else if (method == FilePickerMethod.chooseFromGallery) {
      var permission = await _checkExternalStoragePermission(context);
      if (permission == PermissionStatus.granted) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
        );
        if (result != null && result.files.single.path != null) {
          pickPath = result.files.single.path ?? "";
        }
      }
    }
    if (method == FilePickerMethod.takePhoto) {
      var permission = await _checkCameraPermission(context);
      if (permission == PermissionStatus.granted) {
        try {
          _openIOSBlockingModal(
            context,
            ImageSource.camera,
          );
          XFile? pickedFile =
              await _imagePicker.pickImage(source: ImageSource.camera);
          if (pickedFile != null) {
            pickPath = pickedFile.path;
          }
        } catch (e) {
          // Handle errors...
        }
        processingDialog.hide();
      }
    }

    if (pickPath.isNotEmpty) {
      //
      File file = File(pickPath);
      bool fileValid = await FileUtil.isFileValidSize(file);
      if (fileValid) {
        String extensionName = pickPath.split('.').last.toLowerCase();
        File? fileProcessed;
        if (!Defines.imageFormatsSupported.contains(extensionName)) {
          final compressFile = await FileUtil.compressImageToJpg(
            pickPath,
            quality: 75,
          );
          if (compressFile != null) {
            fileProcessed = compressFile;
          }
        } else {
          fileProcessed = await FileUtil.copyFileToStorage(File(pickPath));
        }

        if (fileProcessed == null) {
          SnackBars.info(message: S.current.fileInvalid).show();
        } else if (filesSelected.contains(fileProcessed.path)) {
          SnackBars.info(message: S.current.fileAlreadyExists).show();
        } else {
          onAddedNewFile?.call(fileProcessed.path);
        }
      } else {
        SnackBars.error(message: S.current.fileTooLarge).show(duration: 5000);
      }
    }
  }

  void _openIOSBlockingModal(
    BuildContext context,
    ImageSource source,
  ) {
    String platform = Platform.operatingSystem;
    if (!_modalIsOpen && source == ImageSource.camera && platform == 'ios') {
      _modalIsOpen = true;
      processingDialog.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (filesSelected.isEmpty) {
      return _buildUploadFileAction(context);
    } else {
      return _buildFilesSelect(context, filesSelected);
    }
  }

  Widget _buildUploadFileAction(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(AppProperties.circleRadius),
      color: AppColors.green700,
      dashPattern: const <double>[5, 3],
      child: InkWell(
        key: const ValueKey('uploadFile'),
        onTap: () => _openChooosePickFileMethod(context),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppProperties.circleRadius),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cloud_upload_outlined,
                  color: AppColors.green700,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.orange700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilesSelect(BuildContext context, List<String> paths) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int idx) {
            return _buildItemFile(context, paths[idx]);
          },
          separatorBuilder: (BuildContext context, int idx) {
            return const SizedBox(height: 4);
          },
          itemCount: paths.length,
        ),
        //
        if (!isSinglePick && filesSelected.length < 5)
          TextButton.icon(
            key: const ValueKey('uploadAnother'),
            onPressed: () => _openChooosePickFileMethod(context),
            icon: const Icon(Icons.add),
            label: Text(S.of(context).uploadAnother),
            style: TextIconButtonBtnStyle.enable(),
          ),
      ],
    );
  }

  Widget _buildItemFile(BuildContext context, String path) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.white.withOpacity(0.08),
            spreadRadius: 20,
            blurRadius: 7,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(path.isImage() ? Icons.image : Icons.picture_as_pdf_outlined),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                FileUtil.getFileName(path),
                style: const TextStyle(
                  color: AppColors.green700,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          IconButton(
            onPressed: () => onRemovedFile?.call(path),
            icon: SvgPicture.asset(
              AssetsConst.closeButton,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
