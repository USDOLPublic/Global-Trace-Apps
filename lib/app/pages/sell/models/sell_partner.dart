import 'package:usdol/app/core.dart';

part 'sell_partner.g.dart';

@HiveType(typeId: ModelTypeDefine.sellPartner)
class SellPartner extends HiveObject {
  SellPartner({
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

  factory SellPartner.fromJson(Map<String, dynamic> json) {
    String? typeName;
    if (json["type"] != null && json["type"] is Map<String, dynamic>) {
      Map<String, dynamic> type = json["type"] as Map<String, dynamic>;
      if (type["name"] != null) {
        typeName = type["name"].toString();
      }
    }
    return SellPartner(
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
    );
  }
}
