import 'package:usdol/app/core.dart';

class RequestInformationScheduleSending {
  RequestInformationScheduleSending({
    required this.fileHttpService,
    required this.requestInfoHttpService,
  });
  final FileHttpService fileHttpService;
  final RequestInformationHttpService requestInfoHttpService;

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

  Future<BaseResp<dynamic>> sendRespondRequest({
    required RespondModel payload,
    required String reportId,
  }) async {
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
    List<String>? uploadFiles = payload.uploadImages;
    if (uploadFiles != null && uploadFiles.isNotEmpty) {
      UploadResult uploadResult = await _uploadFiles(uploadFiles);
      if (uploadResult.isFailed) {
        return uploadResult.getErrorResponse();
      }
      List<String>? blobNameUploaded;
      uploadResult.filesResp?.forEach((element) {
        if (element.blobName != null) {
          blobNameUploaded ??= [];
          blobNameUploaded!.add(element.blobName!);
        }
      });
      payload.uploadedImages = blobNameUploaded;
    }

    ///
    ///Respond
    ///
    var res = await requestInfoHttpService.responseToRequest(payload, reportId);
    return res;
  }
}
