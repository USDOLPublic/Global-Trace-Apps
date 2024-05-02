import 'package:usdol/app/core.dart';

class RiskScanScheduleSending {
  RiskScanScheduleSending({
    required this.fileHttpService,
    required this.riskScanHttpService,
  });
  final FileHttpService fileHttpService;
  final RiskScanHttpService riskScanHttpService;

  Future<UploadResult> _uploadFiles(List<String>? filePaths) async {
    if (filePaths == null || filePaths.isEmpty) {
      return UploadResult.withEmpty();
    }
    final result = await fileHttpService.uploadFiles(filePaths);
    if (result.isHaveRespData()) {
      return UploadResult.withData(result);
    }
    String errorMessage = result.getErrorMessage(
      defaultErrMessage: S.current.unableToUploadTheFile,
    );
    LogUtil.e("Upload Files: " + errorMessage);
    return UploadResult.withError(errorMessage, result);
  }

  Future<BaseResp<dynamic>> sendRiskScanRequest(RiskScanRequest payload) async {
    final isConnected = await NetworkUtil.isConnected();
    if (!isConnected) {
      return BaseResp<dynamic>.withError(
        errorMsg: S.current.noInternetConnection,
        statusCode: status408RequestTimeout,
      );
    }

    ///
    ///Upload files
    ///
    List<String> uploadFiles = payload.uploadFiles;
    if (uploadFiles.isNotEmpty) {
      UploadResult uploadResult = await _uploadFiles(uploadFiles);
      if (uploadResult.isFailed) {
        return uploadResult.getErrorResponse();
      }
      List<String> blobNameUploaded = <String>[];
      uploadResult.filesResp?.forEach((element) {
        if (element.blobName != null) {
          blobNameUploaded.add(element.blobName!);
        }
      });
      payload.uploadFiles = blobNameUploaded;
    }

    ///
    ///Respond
    ///
    var res = await riskScanHttpService.addRiskScan(payload);
    return res;
  }
}
