import 'dart:convert';

import 'package:amplify/data/services/storage_service.dart';
import 'package:http/http.dart' as http;

class BaseService {
  final String loginBaseUrl = 'https://authtest.amplifyplatform.com';

  final String baseUrl = 'https://api-test.amplifyplatform.com/';

  Future<BaseResModel> doMultipartReqPost(
      String url, Map<String, String> reqFields,
      {Map<String, String>? headers}) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(reqFields);
    if (headers != null) {
      request.headers.addAll(headers);
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return BaseResModel(
          statusCode: response.statusCode,
          response: jsonDecode(await response.stream.bytesToString()));
    } else {
      throw ApiException(
          statusCode: response.statusCode, message: response.reasonPhrase);
    }
  }
}

Future<BaseResModel> doGet(String url, {Map<String, String>? headers}) async {
  var request = http.Request('GET', Uri.parse(url));
  if (headers != null) {
    request.headers.addAll(headers);
  }
  request.headers.addAll(await getDefaultHeaders());
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return BaseResModel(
        statusCode: response.statusCode,
        response: jsonDecode(await response.stream.bytesToString()));
  } else {
    throw ApiException(
        statusCode: response.statusCode, message: response.reasonPhrase);
  }
}

Future<Map<String, String>> getDefaultHeaders() async {
  Map<String, String> defaultHeaders = {
    'Connection': 'keep-alive',
    'accept': '*/*',
    'content-type': 'application/json',
    'Access-Control-Allow-Origin': '*'
  };
  var token = await StorageService().getString(StorageService.accessToken);
  if (token != null && token.isNotEmpty) {
    defaultHeaders['Authorization'] = 'Bearer $token';
  }
  return defaultHeaders;
}

class BaseResModel {
  dynamic response;
  int statusCode;

  BaseResModel({this.response, required this.statusCode});
}

class ApiException implements Exception {
  final dynamic message;
  final int statusCode;

  ApiException({this.message, required this.statusCode});
}
