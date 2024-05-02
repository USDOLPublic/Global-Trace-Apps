import 'package:usdol/common/common.dart';

class CottonAttribute {
  String trashContent;
  double moistureLevel;
  String? cottonCertification;
  String? grade;

  CottonAttribute({
    this.cottonCertification,
    required this.grade,
    required this.moistureLevel,
    required this.trashContent,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> mapData = <String, dynamic>{
      "trashContent": trashContent,
      "moistureLevel": moistureLevel,
    };
    if (grade != null && grade!.isNotEmpty) {
      mapData["grade"] = grade;
    }

    if (cottonCertification != null && cottonCertification!.isNotEmpty) {
      mapData["cottonCertification"] = cottonCertification;
    }
    return mapData;
  }

  factory CottonAttribute.fromJson(Map<String, dynamic> json) => CottonAttribute(
        trashContent: (json['trashContent'] ?? '').toString(),
        moistureLevel: (json.getDouble('moistureLevel') ?? 0),
        cottonCertification: (json['cottonCertification'] ?? '').toString(),
        grade: (json['grade'] ?? '').toString(),
      );

  factory CottonAttribute.empty() => CottonAttribute(
        trashContent: "",
        moistureLevel: 0,
        cottonCertification: "",
        grade: "",
      );
}
