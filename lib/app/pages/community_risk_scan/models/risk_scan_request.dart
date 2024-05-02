import 'package:json_annotation/json_annotation.dart';
import 'package:usdol/app/core.dart';
part 'risk_scan_request.g.dart';

@JsonSerializable()
class RiskScanRequest {
  String? id;
  String facilityId;
  String location;
  DateTime recordedAt;
  int priority;
  List<LaborRisksModel> laborRisks;
  String message;
  String? auditReportNumber;
  List<String> uploadFiles;

  RiskScanRequest({
    this.id,
    required this.facilityId,
    required this.location,
    required this.recordedAt,
    required this.priority,
    required this.laborRisks,
    required this.message,
    this.auditReportNumber,
    required this.uploadFiles,
  });

  factory RiskScanRequest.fromJson(Map<String, dynamic> json) =>
      _$RiskScanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RiskScanRequestToJson(this);

  Map<String, dynamic> toRequest() {
    Map<String, dynamic> mapData = <String, dynamic>{
      "facilityId": facilityId,
      "location": location,
      "recordedAt": recordedAt.millisecondsSinceEpoch ~/ 1000,
      "priority": priority,
      "laborRisks":
          List<dynamic>.from(laborRisks.map<dynamic>((e) => e.toRequest())),
      "message": message,
      "auditReportNumber": auditReportNumber,
    };
    if (uploadFiles.isNotEmpty) {
      mapData["uploadFiles"] = uploadFiles;
    }
    return mapData;
  }
}
