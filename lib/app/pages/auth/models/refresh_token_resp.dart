class RefreshTokenResp {
  RefreshTokenResp({
    this.accessToken = "",
    this.expiresAt = 0,
    this.refreshToken = "",
  });

  String accessToken;
  String refreshToken;
  int expiresAt;

  factory RefreshTokenResp.fromJson(Map<String, dynamic> json) => RefreshTokenResp(
        accessToken: (json["access_token"] ?? "").toString(),
        refreshToken: (json["refreshToken"] ?? "").toString(),
        expiresAt: json["expiresAt"] == null ? 0 : json["expiresAt"] as int,
      );
}
