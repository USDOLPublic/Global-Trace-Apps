import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'manual_added_data_request.g.dart';

@JsonSerializable()
class ManualAddedDataRequest {
  final String? productDefinitionId;
  final List<ManualAddedProductRequest>? manualAddedProducts;

  ManualAddedDataRequest({
    this.productDefinitionId,
    this.manualAddedProducts,
  });

  factory ManualAddedDataRequest.fromJson(Map<String, dynamic> json) =>
      _$ManualAddedDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManualAddedDataRequestToJson(this);

  Future<List<UploadResult>> uploadFileAttachments({
    required Future<UploadResult> Function(List<String>) uploadFile,
  }) async {
    List<Future<List<UploadResult>>> uploadTasks =
        <Future<List<UploadResult>>>[];
    manualAddedProducts?.forEach((element) {
      uploadTasks.add(element.uploadFileAttachments(uploadFile: uploadFile));
    });
    List<UploadResult> uploadResults = <UploadResult>[];
    List<List<UploadResult>> uploadData = await Future.wait(uploadTasks);
    for (var element in uploadData) {
      if (element.isNotEmpty) {
        uploadResults.addAll(element);
      }
    }
    return uploadResults;
  }
}
