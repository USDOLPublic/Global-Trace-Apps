import 'package:usdol/app/core.dart';

part 'purchase_partner.g.dart';

@HiveType(typeId: ModelTypeDefine.purchasePartner)
class PurchasePartner extends HiveObject {
  PurchasePartner({
    required this.id,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.name,
    this.address,
    this.district,
    this.province,
    this.country,
    this.traderName,
    this.certification,
    this.oarId,
    this.businessRegisterNumber,
    this.reconciliationStartAt,
    this.reconciliationDuration,
    this.deletedAt,
    this.farmGroupId,
    this.farmId,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  int? createdAt;
  @HiveField(2)
  int? updatedAt;
  @HiveField(3)
  String? type;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? address;
  @HiveField(6)
  String? district;
  @HiveField(7)
  String? province;
  @HiveField(8)
  String? country;
  @HiveField(9)
  String? traderName;
  @HiveField(10)
  String? certification;
  @HiveField(11)
  String? oarId;
  @HiveField(12)
  String? businessRegisterNumber;
  @HiveField(13)
  int? reconciliationStartAt;
  @HiveField(14)
  String? reconciliationDuration;
  @HiveField(15)
  int? deletedAt;
  @HiveField(16)
  String? farmGroupId;
  @HiveField(17)
  String? farmId;

  factory PurchasePartner.fromJson(Map<String, dynamic> json) {
    //Get farm group info
    String? farmGroupId;
    Map<String, dynamic> farmGroupObj = json;
    if (json["farmGroup"] != null &&
        json["farmGroup"] is Map<String, dynamic>) {
      farmGroupObj = json["farmGroup"] as Map<String, dynamic>;
    }
    if (farmGroupObj["farmGroupProfile"] != null &&
        farmGroupObj["farmGroupProfile"] is Map<String, dynamic>) {
      Map<String, dynamic> farmGroupProfile =
          farmGroupObj["farmGroupProfile"] as Map<String, dynamic>;
      if (farmGroupProfile["farmGroupId"] != null) {
        farmGroupId = farmGroupProfile["farmGroupId"].toString();
      }
    }
    //Get farm info
    String? farmId;
    if (json["farmProfile"] != null &&
        json["farmProfile"] is Map<String, dynamic>) {
      Map<String, dynamic> farmProfile =
          json["farmProfile"] as Map<String, dynamic>;
      if (farmProfile["farmProfileId"] != null) {
        farmId = farmProfile["farmProfileId"].toString();
      }
    }
    String? typeName;
    if (json["type"] != null && json["type"] is Map<String, dynamic>) {
      Map<String, dynamic> type = json["type"] as Map<String, dynamic>;
      if (type["name"] != null) {
        typeName = type["name"].toString();
      }
    }

    return PurchasePartner(
      id: (json["id"] ?? "").toString(),
      createdAt: (json["createdAt"] ?? 0) as int,
      updatedAt: (json["updatedAt"] ?? 0) as int,
      type: typeName,
      name: (json["name"] ?? "").toString(),
      address: (json["address"] ?? "").toString(),
      district: (json["district"] ?? "").toString(),
      province: (json["province"] ?? "").toString(),
      country: (json["country"] ?? "").toString(),
      traderName: (json["traderName"] ?? "").toString(),
      certification: (json["certification"] ?? "").toString(),
      oarId: (json["oarId"] ?? "").toString(),
      businessRegisterNumber: (json["businessRegisterNumber"] ?? "").toString(),
      reconciliationStartAt: (json["reconciliationStartAt"] ?? 0) as int,
      reconciliationDuration: (json["reconciliationDuration"] ?? "").toString(),
      deletedAt: (json["deletedAt"] ?? 0) as int,
      farmGroupId: farmGroupId,
      farmId: farmId,
    );
  }
}
