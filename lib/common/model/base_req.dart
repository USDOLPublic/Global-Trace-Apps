import 'dart:convert';
abstract class BaseReq{
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return jsonEncode(this);
  }
}