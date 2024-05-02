import 'package:json_annotation/json_annotation.dart';
part 'record_product_request.g.dart';

@JsonSerializable()
class RecordProductRequest {
  double totalWeight;
  String weightUnit;
  int recordedAt;
  List<String> uploadProofs;

  RecordProductRequest({
    required this.totalWeight,
    required this.weightUnit,
    required this.recordedAt,
    required this.uploadProofs,
  });

  factory RecordProductRequest.fromJson(Map<String, dynamic> json) =>
      _$RecordProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RecordProductRequestToJson(this);

  Map<String, dynamic> toRequest() {
    Map<String, dynamic> payload = _$RecordProductRequestToJson(this);
    payload.remove('uploadProofs');
    return payload;
  }
}
