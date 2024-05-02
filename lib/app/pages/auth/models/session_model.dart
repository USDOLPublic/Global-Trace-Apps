import 'package:json_annotation/json_annotation.dart';
part 'session_model.g.dart';

@JsonSerializable()
class SessionModel {
  SessionModel({
    this.accessToken = "",
    this.userId = "",
    this.expireAt = 0,
    this.refreshToken = "",
    this.email,
    this.firstName,
    this.lastName,
  });

  String accessToken;
  String refreshToken;
  int expireAt;
  String userId;
  String? email;
  String? firstName;
  String? lastName;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
