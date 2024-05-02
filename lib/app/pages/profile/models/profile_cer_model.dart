import 'package:usdol/app/core.dart';

part 'profile_cer_model.g.dart';

@HiveType(typeId: ModelTypeDefine.profileCertification)
class ProfileCerModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;

  ProfileCerModel({required this.id, required this.name});

  factory ProfileCerModel.fromJson(Map<String, dynamic> json) => ProfileCerModel(
        id: (json["id"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
      );
}
