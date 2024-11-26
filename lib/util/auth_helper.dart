import 'dart:convert';
import 'dart:math';
import 'package:amplify/data/api_services/storage_service.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'package:pkce/pkce.dart';

var pkce;

//TODO Using As it is for POC
final class AuthHelper {
  static const scheme = "https";
  static const host = "authtest.amplifyplatform.com";

  // static const host = "localhost";
  static const port = 44333;
  static const authPath = "/connect/authorize";
  static const tokenPath = "/connect/token";
  static const clientId = "ClientPortalApp";
  static const redirectUri = "http://localhost:50555/auth.html";
  static var authParameters = {
    "client_id": clientId,
    "response_type": "code id_token",
    "scope": "openid profile apiv1 offline_access",
    "redirect_uri": redirectUri
  };
  static var tokenParameters = {
    "client_id": clientId,
    "grant_type": "authorization_code",
    "redirect_uri": redirectUri,
  };
  static var refreshParameters = {
    "client_id": clientId,
    "grant_type": "refresh_token",
    // "redirect_uri": redirect_uri,
  };

  // This is the main entry point
  // Calling this function will handle authorization and grab the tokens from the server
  // access token is at global.accessToken
  // refresh token is at global.refreshToken
  // Return bool: Whether login was successful or not
  static Future<bool> authWrapper() async {
    String authRes = await _handleAuth();
    var authPayload = _parseAuthPayload(authRes);
    if (authPayload.isEmpty) {
      return false;
    }
    var isTokenSuccessful = await _handleToken(authPayload);
    return isTokenSuccessful;
  }

  static Future<bool> handleRefresh() async {
    refreshParameters['refresh_token'] =
        (await StorageService().getString(StorageService.refreshToken)) ?? '';
    http.Response res;

    try {
      var url = Uri(
          scheme: scheme,
          host: host,
          path: tokenPath,
          queryParameters: refreshParameters);
      res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: refreshParameters,
      );
    } catch (e) {
      print('Error in handleRefresh: $e');
      return false;
    }
    return _parseTokenRes(res);
  }

  static Future<bool> isTokenValid() async {
    if (!(await StorageService().getBool(StorageService.isLogin))) {
      return false;
    }
    if (DateTime.now().isAfter(DateTime.fromMillisecondsSinceEpoch(
        await StorageService().getInt(StorageService.expiryDate)))) {
      return false;
    }
    return true;
  }

  static Future<bool> isTokenExpired() async {
    return !(await isTokenValid()) &&
        (await StorageService().getBool(StorageService.isLogin));
  }

  static String _generateNonce(int length) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join();
  }

  static Future<bool> doMobileUrlParse(String res) async {
    var authPayload = _parseAuthPayload(res);
    if (authPayload.isEmpty) {
      return false;
    }
    var isTokenSuccessful = await _handleToken(authPayload);
    return isTokenSuccessful;
  }

  static Map<String, String> _parseAuthPayload(String res) {
    Map<String, String> retItems = {};
    var parameters = res.split('#');
    if (parameters.length < 2) {
      return {};
    }
    var parameterList = parameters[1].split('&');
    if (parameterList.isEmpty) {
      return {};
    }
    for (var parameter in parameterList) {
      var parItemized = parameter.split('=');
      if (parItemized.length == 2) {
        retItems[parItemized[0]] = parItemized[1];
      } else {
        print('Error on $parameter');
      }
    }
    if (retItems['code'] == null) {
      print('Missing code field in return payload');
      return {};
    }
    return retItems;
  }

  static Future<String> _handleAuth() async {
    authParameters['nonce'] = _generateNonce(96);
    pkce = PkcePair.generate();
    authParameters['code_challenge'] = pkce.codeChallenge;
    authParameters['code_challenge_method'] = 'S256';
    try {
      var url = Uri(
          scheme: scheme,
          host: host,
          path: authPath,
          queryParameters: authParameters);
      final result = await FlutterWebAuth2.authenticate(
          url: url.toString(), callbackUrlScheme: 'http');
      return result;
    } catch (e) {
      print(e);
      return '';
    }
  }

  static Uri getLoginPopUrl() {
    authParameters['nonce'] = _generateNonce(96);
    pkce = PkcePair.generate();
    authParameters['code_challenge'] = pkce.codeChallenge;
    authParameters['code_challenge_method'] = 'S256';
    return Uri(
        scheme: scheme,
        host: host,
        path: authPath,
        queryParameters: authParameters);
  }

  static bool _parseTokenRes(http.Response res) {
    if (jsonDecode(res.body)['access_token'] == null ||
        jsonDecode(res.body)['refresh_token'] == null ||
        jsonDecode(res.body)['expires_in'] == null) {
      return false;
    }
    String accessToken = jsonDecode(res.body)['access_token'] as String;
    StorageService().setString(StorageService.accessToken, accessToken);
    String refreshToken = jsonDecode(res.body)['refresh_token'] as String;
    StorageService().setString(StorageService.refreshToken, refreshToken);
    DateTime expirationTime = DateTime.now()
        .add(Duration(seconds: jsonDecode(res.body)['expires_in']));
    StorageService().setInt(
        StorageService.expiryDate, expirationTime.millisecondsSinceEpoch);
    StorageService().setBool(StorageService.isLogin, true);
    return true;
  }

  static Future<bool> _handleToken(Map<String, String> authPayload) async {
    tokenParameters['code'] = authPayload['code'] as String;
    tokenParameters['code_verifier'] = pkce.codeVerifier;
    http.Response res;

    try {
      var url = Uri(
          scheme: scheme,
          host: host,
          path: tokenPath,
          queryParameters: tokenParameters);
      res = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: tokenParameters,
      );
    } catch (e) {
      print('Error in handleToken: $e');
      return false;
    }
    return _parseTokenRes(res);
  }
}
