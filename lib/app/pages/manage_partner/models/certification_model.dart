import 'package:usdol/app/core.dart';

part 'certification_model.g.dart';

@HiveType(typeId: ModelTypeDefine.certification)
class CertificationModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  CertificationModel({required this.id, required this.name});

  factory CertificationModel.fromJson(Map<String, dynamic> json) => CertificationModel(
        id: (json["id"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
      );
}
