import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:amplify/data/api_services/storage_service.dart';

class BaseService {
  final String baseUrl = 'https://api-test.amplifyplatform.com/v1';
  final String serviceURL = 'https://gitait.com/amplifyAPI';
  final String loginBaseUrl = 'https://authtest.amplifyplatform.com';

  // POST request method
  Future<BaseResModel> doPost(String url, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    try {
      headers ??= await getDefaultHeaders();
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException(message: 'Error in doPost: ${e.toString()}', statusCode: 500);
    }
  }

  // POST request method with dynamic body (for list or other dynamic data)
  Future<BaseResModel> doPostData(String url, dynamic body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: await getDefaultHeaders(),
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return BaseResModel.fromJson(jsonDecode(response.body));
      } else {
        throw ApiException(message: 'Failed to fetch data', statusCode: response.statusCode);
      }
    } catch (e) {
      throw ApiException(message: 'Error in doPostData: ${e.toString()}', statusCode: 500);
    }
  }

  // GET request method
  Future<BaseResModel> doGet(String url, {Map<String, String>? headers}) async {
    try {
      headers ??= await getDefaultHeaders();
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException(message: 'Error in doGet: ${e.toString()}', statusCode: 500);
    }
  }

  // PUT request method
  Future<BaseResModel> doPut(String url, Map<String, dynamic> body, {Map<String, String>? headers}) async {
    try {
      headers ??= await getDefaultHeaders();
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException(message: 'Error in doPut: ${e.toString()}', statusCode: 500);
    }
  }

  // Multipart POST request method
  Future<BaseResModel> doMultipartReqPost(String url, Map<String, String> reqFields, {Map<String, String>? headers}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(reqFields);
      if (headers != null) {
        request.headers.addAll(headers);
      }

      http.StreamedResponse response = await request.send();
      return _handleStreamedResponse(response);
    } catch (e) {
      throw ApiException(message: 'Error in doMultipartReqPost: ${e.toString()}', statusCode: 500);
    }
  }

// Handle normal HTTP response
Future<BaseResModel> _handleResponse(http.Response response) async {
  if (response.statusCode == 200) {
    // Parse the response body to extract statusCode and data
    var jsonResponse = jsonDecode(response.body);
    
    return BaseResModel(
      statusCode: jsonResponse['statusCode'], // Use 'statusCode' from the JSON response
      data: jsonResponse['data'], // Extract 'data' from the JSON response
    );
  } else {
    throw ApiException(
      statusCode: response.statusCode,
      message: 'Request failed with status: ${response.statusCode}, body: ${response.body}',
    );
  }
}

// Handle streamed response (for multipart and other stream-based responses)
Future<BaseResModel> _handleStreamedResponse(http.StreamedResponse response) async {
  if (response.statusCode == 200) {
    String responseBody = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseBody);
    
    return BaseResModel(
      statusCode: jsonResponse['statusCode'], // Use 'statusCode' from the JSON response
      data: jsonResponse['data'], // Extract 'data' from the JSON response
    );
  } else {
    throw ApiException(
      statusCode: response.statusCode,
      message: 'Streamed request failed with status: ${response.statusCode}, reason: ${response.reasonPhrase}',
    );
  }
}


  // Fetch default headers, including Authorization if available
  Future<Map<String, String>> getDefaultHeaders() async {
    Map<String, String> defaultHeaders = {
      'Connection': 'keep-alive',
      'Accept': '*/*',
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };

    var token = await StorageService().getString(StorageService.accessToken);
    if (token != null && token.isNotEmpty) {
      defaultHeaders['Authorization'] = 'Bearer $token';
    }

    return defaultHeaders;
  }
}


class BaseResModel {
  dynamic data; // Use 'data' instead of 'response'
  int statusCode;

  BaseResModel({this.data, required this.statusCode});

  // Factory constructor for parsing JSON into a BaseResModel object
  factory BaseResModel.fromJson(Map<String, dynamic> json) {
    return BaseResModel(
      data: json['data'],  // Adjusted to match API response structure
      statusCode: json['statusCode'],
    );
  }

  // Convert the model back to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'statusCode': statusCode,
    };
  }
}



class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException({required this.message, required this.statusCode});

  @override
  String toString() {
    return 'ApiException: $message (Status code: $statusCode)';
  }
}

