import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pkce/pkce.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'globals.dart' as globals;

var pkce;
const bool RUNNING_LOCALLY = false;

final class Auth {
  static const scheme = "https";
  static const host = RUNNING_LOCALLY ? "localhost" : "authtest.amplifyplatform.com";
  static const port = 44333;
  static const authPath = "/connect/authorize";
  static const tokenPath = "/connect/token";
  static const clientId = "ClientPortalApp";
  static const redirectUri = "http://localhost:50555/auth.html";
  static String state = ""; 
  static var authParameters = {
    "client_id": clientId,
    "response_type": "code id_token",
    "scope": "openid profile client_apiv1 offline_access",
    "redirect_uri": redirectUri,
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
    refreshParameters['refresh_token'] = globals.refreshToken;
    http.Response res;

    try {
      var url = Uri(
          scheme: scheme,
          host: host,
          port: RUNNING_LOCALLY ? port : null,
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


  static bool isTokenValid() {
    if (!globals.isAuthorized) {
      return false;
    }
    if (DateTime.now().isAfter(globals.expirationTime)) {
      return false;
    }
    return true;
  }

  static bool isTokenExpired() {
    return !isTokenValid() && globals.isAuthorized;
  }

  static String _generateNonce(int length) {
    const characters =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random.secure();
    return List.generate(
            length, (index) => characters[random.nextInt(characters.length)])
        .join();
  }

  static String _generateState({int firmId = 0, int advisorId = 0}) => '${_generateNonce(10)}.$firmId.$advisorId'; 
  static bool _isValidState(String returnedState) => returnedState == authParameters['state'];

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
    if (retItems['state'] == null || !_isValidState(retItems['state'].toString())) {
      print('Invalid state returned from auth server, potential CSRF attack');
      return {};
    }
    return retItems;
  }

  static Future<String> _handleAuth() async {
    authParameters['nonce'] = _generateNonce(96);
    pkce = PkcePair.generate();
    authParameters['code_challenge'] = pkce.codeChallenge;
    authParameters['code_challenge_method'] = 'S256';
    authParameters['state'] = _generateState(firmId: 1, advisorId: 1);
    try {
      var url = Uri(
          scheme: scheme,
          host: host,
          port: RUNNING_LOCALLY ? port : null,
          path: authPath,
          queryParameters: authParameters);
      final result = await FlutterWebAuth2.authenticate(
          url: url.toString(), callbackUrlScheme: 'https');
      return result;
    } catch (e) {
      print(e);
      return '';
    }
  }

  static bool _parseTokenRes(http.Response res) {
    if (jsonDecode(res.body)['access_token'] == null ||
        jsonDecode(res.body)['refresh_token'] == null ||
        jsonDecode(res.body)['expires_in'] == null) {
      return false;
    }
    globals.accessToken = jsonDecode(res.body)['access_token'] as String;
    globals.refreshToken = jsonDecode(res.body)['refresh_token'] as String;
    globals.expirationTime = DateTime.now()
        .add(Duration(seconds: jsonDecode(res.body)['expires_in']));
    globals.isAuthorized = true;
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
          port: RUNNING_LOCALLY ? port : null,
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
