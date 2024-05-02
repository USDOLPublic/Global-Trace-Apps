import 'package:usdol/app/core.dart';

enum UploadStatus {
  success,
  failed,
  none,
}

class UploadResult {
  List<UploadFileResp>? filesResp;
  String? errorMessage;
  BaseResp? errorResponse;
  UploadStatus status;

  UploadResult({
    required this.status,
    this.errorMessage,
    this.errorResponse,
    this.filesResp,
  });

  bool get isSuccess => status == UploadStatus.success;
  bool get isFailed => status == UploadStatus.failed;
  bool get isNone => status == UploadStatus.none;

  factory UploadResult.withData(BaseResp<List<UploadFileResp>?> result) =>
      UploadResult(
        status: UploadStatus.success,
        filesResp: result.data,
      );
  factory UploadResult.withError(
    String errorMessage,
    BaseResp errorRes,
  ) =>
      UploadResult(
        errorMessage: errorMessage,
        errorResponse: errorRes,
        status: UploadStatus.failed,
      );
  factory UploadResult.withEmpty() => UploadResult(
        filesResp: List.empty(),
        status: UploadStatus.none,
      );

  BaseResp<dynamic> getErrorResponse() {
    return errorResponse ??
        BaseResp<dynamic>.withError(
          errorMsg: S.current.unableToUploadTheFile,
        );
  }
}
