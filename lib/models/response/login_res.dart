import 'package:amplify/models/response/base_res.dart';

class LoginRes extends BaseRes {
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? refreshToken;
  String? scope;

  LoginRes(
      {this.accessToken,
      this.expiresIn,
      this.tokenType,
      this.refreshToken,
      this.scope})
      : super();

  LoginRes.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    accessToken = json['access_token'];
    expiresIn = json['expires_in'];
    tokenType = json['token_type'];
    refreshToken = json['refresh_token'];
    scope = json['scope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['token_type'] = tokenType;
    data['refresh_token'] = refreshToken;
    data['scope'] = scope;
    return data;
  }
}
