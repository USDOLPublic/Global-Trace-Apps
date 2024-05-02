import 'package:usdol/app/core.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_resp.g.dart';

@JsonSerializable()
class LoginResp extends BaseObject {
  LoginResp({
    this.user,
    this.token,
    this.refreshToken,
    this.expireAt,
  });

  UserModel? user;
  String? token;
  String? refreshToken;
  int? expireAt;

  factory LoginResp.fromJson(Map<String, dynamic> json) =>
      _$LoginRespFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRespToJson(this);
}
