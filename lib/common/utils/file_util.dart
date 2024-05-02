import 'dart:io';
import 'dart:typed_data';

import '/common/common.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  static String _dirPath = "";
  static Future<String> getDir() async {
    if (ObjectUtil.isEmptyString(_dirPath)) {
      _dirPath = (await getApplicationDocumentsDirectory()).path;
    }
    return _dirPath;
  }

  static Future<File> writeFileToStorage(
      List<int> itemData, String fileName) async {
    String dir = await getDir();
    String filePath = "$dir/$fileName";

    File fileData = File(filePath);
    if (await fileData.exists()) {
      await fileData.delete();
    }
    return await fileData.writeAsBytes(itemData);
  }

  static Future<File> writeImageToStorage(Uint8List itemData,
      {String? fileName}) async {
    if (ObjectUtil.isEmptyString(fileName)) {
      fileName = const Uuid().v1() + ".png";
    }
    final buffer = itemData.buffer;
    return await writeFileToStorage(
        buffer.asUint8List(itemData.offsetInBytes, itemData.lengthInBytes),
        fileName!);
  }

  static Future<bool> isExistsFile(String fileName) async {
    String dir = await getDir();
    String filePath = "$dir/$fileName";
    File fileData = File(filePath);
    if (await fileData.exists()) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getFilePath(String fileName) async {
    String dir = await getDir();
    String filePath = "$dir/$fileName";
    File fileData = File(filePath);
    if (await fileData.exists()) {
      return fileData.path;
    } else {
      return "";
    }
  }

  static Future<File> copyFileToStorage(File origin, {String? fileName}) async {
    String dir = await getDir();
    String fileNamePath = fileName ?? getFileName(origin.path);
    String filePath = "$dir/$fileNamePath";

    File fileData = File(filePath);
    if (await fileData.exists()) {
      await fileData.delete();
    }
    return await origin.copy(filePath);
  }

  static Future<bool> deleteFileInStorage(String filePath) async {
    File fileData = File(filePath);
    if (await fileData.exists()) {
      await fileData.delete();
    }
    return true;
  }

  static Future<File?> compressImageToJpg(String filePath,
      {int quality = 95}) async {
    String dir = await getDir();
    String fileNamePath = getFileName(filePath);
    int extension = fileNamePath.split('.').last.length;
    String fileName = fileNamePath.substring(
      0,
      fileNamePath.length - extension - 1,
    );
    final targetPath = "$dir/$fileName.jpg";
    try {
      var result = await FlutterImageCompress.compressAndGetFile(
        filePath,
        targetPath,
        //minWidth: 1080,
        //minHeight: 1080,
        quality: quality,
      );
      return result;
    } catch (e) {
      LogUtil.e("compressImageToJpg Error: " + e.toString());
      return null;
    }
  }

  static String getFileName(String path) {
    return path.split("/").last;
  }

  static String getFileNameByUrl(String url, {bool isSkipUUID = false}) {
    String fileName = "";
    try {
      Uri uri = Uri.parse(url);
      fileName = uri.path.split('/').last;
      fileName = Uri.decodeComponent(fileName);
    } catch (e) {
      LogUtil.e("getFileNameByUrl error: " + e.toString());
      fileName = url.split('/').last;
    }
    //remove uuid in file name if the file name have start with uuid
    if (isSkipUUID && fileName.length > 36) {
      String uuidSplit = fileName.substring(0, 36);
      if (Uuid.isValidUUID(fromString: uuidSplit) &&
          fileName.substring(36, 37) == "-") {
        fileName = fileName.substring(37, fileName.length);
      }
    }
    return removeAccesKeyInFile(fileName) ?? "";
  }

  static String? removeAccesKeyInFile(String? imageUrl) {
    Uri? uriImage = Uri.tryParse(imageUrl!);
    return uriImage?.path;
  }

  static Future<bool> isFileValidSize(File file,
      {int maxSizeOfFile = 10}) async {
    var fileSize = await file.length();
    LogUtil.d("File size: " +
        fileSize.toString() +
        " max: " +
        (maxSizeOfFile * 1024 * 1024).toString());
    if (fileSize >= (maxSizeOfFile * 1024 * 1024)) {
      return false;
    }
    return true;
  }
}
