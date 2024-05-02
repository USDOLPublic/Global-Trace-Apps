import 'package:usdol/app/core.dart';

class SaqSubmitResp {
  final SAQLabel? title;
  final int? questionOrder;
  final String? error;

  SaqSubmitResp({
    this.title,
    this.questionOrder,
    this.error,
  });

  factory SaqSubmitResp.fromJson(dynamic json) => SaqSubmitResp(
        title: json["title"] == null ? null : SAQLabel.fromJson(json["title"]),
        questionOrder: (json["questionOrder"] ?? 0) as int?,
        error: (json["error"] ?? '').toString(),
      );
}
