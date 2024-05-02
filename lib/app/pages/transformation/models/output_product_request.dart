import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'output_product_request.g.dart';

@JsonSerializable()
class OutputProductRequest {
  final String? productDefinitionId;
  final List<ManualAddedProductRequest>? outputProducts;

  OutputProductRequest({
    this.productDefinitionId,
    this.outputProducts,
  });

  factory OutputProductRequest.fromJson(Map<String, dynamic> json) =>
      _$OutputProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OutputProductRequestToJson(this);

  Future<List<UploadResult>> uploadFileAttachments({
    required Future<UploadResult> Function(List<String>) uploadFile,
  }) async {
    List<Future<List<UploadResult>>> uploadTasks =
        <Future<List<UploadResult>>>[];
    outputProducts?.forEach((element) {
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
