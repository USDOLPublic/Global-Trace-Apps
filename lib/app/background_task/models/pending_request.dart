import 'dart:convert';
import 'package:usdol/app/core.dart';
part 'pending_request.g.dart';

@HiveType(typeId: ModelTypeDefine.pendingRequest)
class PendingRequestModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime createAt;
  @HiveField(2)
  String type;
  @HiveField(3)
  String status;
  @HiveField(4)
  String requestData;
  @HiveField(5)
  String errorCause;
  @HiveField(6)
  String? userId;

  PendingRequestModel({
    required this.id,
    required this.createAt,
    required this.type,
    required this.status,
    required this.requestData,
    this.errorCause = "",
    this.userId,
  });

  factory PendingRequestModel.pending(dynamic object, RequestType type) {
    MainController main = Get.find<MainController>();
    return PendingRequestModel(
      createAt: DateTime.now(),
      id: const Uuid().v1(),
      type: type.asString(),
      status: RequestStatus.pending.asString(),
      requestData: jsonEncode(object),
      userId: main.userInfo.id,
    );
  }

  Map<String, dynamic>? getRequestDataJs() {
    dynamic data = jsonDecode(requestData);
    if (data is Map<String, dynamic>) {
      return data;
    } else {
      return null;
    }
  }

  RequestType get requestType {
    RequestType? requestType = EnumUtil.enumValueFromString(
      type,
      RequestType.values,
    );
    return requestType ?? RequestType.none;
  }

  RequestStatus get requestStatus {
    RequestStatus? requestStatus = EnumUtil.enumValueFromString(
      status,
      RequestStatus.values,
    );
    return requestStatus ?? RequestStatus.failed;
  }

  bool get isPending => status == RequestStatus.pending.asString();

  dynamic getRequestData() {
    Map<String, dynamic>? dataJson = getRequestDataJs();
    if (dataJson == null) {
      return null;
    }
    switch (requestType) {
      case RequestType.purchase:
        return PurchaseRequest.fromJson(dataJson);
      case RequestType.sell:
        return SellRequest.fromJson(dataJson);
      case RequestType.assignProduct:
        return TransformRequest.fromJson(dataJson);
      case RequestType.transport:
        return TransportRequest.fromJson(dataJson);
      case RequestType.recordByProduct:
        return RecordProductRequest.fromJson(dataJson);
      case RequestType.community:
        return RiskScanRequest.fromJson(dataJson);
      case RequestType.requestInformation:
        return RespondModel.fromJson(dataJson);
      default:
        return null;
    }
  }
}
