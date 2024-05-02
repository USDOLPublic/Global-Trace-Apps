import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'severity_model.g.dart';

@HiveType(typeId: ModelTypeDefine.severity)
@JsonSerializable()
class SeverityModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  int index;
  @HiveField(3)
  int? color;
  @HiveField(4)
  int? value;

  SeverityModel({
    required this.id,
    this.name,
    required this.index,
    this.color,
    this.value,
  });
  factory SeverityModel.fromJson(Map<String, dynamic> json) =>
      SeverityModel(
        id: (json["id"] ?? "").toString(),
        name: (json["name"] ?? "").toString(),
        index: 0,
        color: (json['color'] ?? 0xff3E415B) as int,
        value: json['value'] as int,
      );

  Map<String, dynamic> toJson() => _$SeverityModelToJson(this);
}
