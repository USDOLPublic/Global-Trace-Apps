import 'package:usdol/app/core.dart';

class SAQLabel {
  SAQLabel({
    required this.value,
    required this.data,
  }) {
    originValue = value;
  }

  String value;
  String originValue = "";
  Map<String, dynamic> data;

  factory SAQLabel.fromJson(dynamic json, {String language = "en"}) {
    String textValue = "";
    if (json != null && json is Map<String, dynamic>) {
      if (json[language] != null && json[language]!.toString().isNotEmpty) {
        textValue = json[language]!.toString();
      } else {
        textValue = (json[AppLanguage.defaultLanguage] ?? "").toString();
      }
    }
    return SAQLabel(
      value: textValue,
      data: (json == null || json is! Map<String, dynamic>)
          ? <String, dynamic>{}
          : json,
    );
  }

  factory SAQLabel.fromString(String label, {String language = "en"}) =>
      SAQLabel(
        value: label,
        data: <String, dynamic>{
          language: label,
        },
      );

  Map<String, dynamic> toUpload() {
    return data;
  }

  void setOtherAnswer(String answer, {String language = "en"}) {
    value = answer;
    data[language] = answer;
  }
}
