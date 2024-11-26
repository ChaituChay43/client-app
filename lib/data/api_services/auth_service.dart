import 'package:amplify/constants/app_constants.dart';
import 'package:amplify/data/api_services/base_service.dart';
import 'package:amplify/models/response/login_res.dart';

class AuthService extends BaseService {
  Future<LoginRes> login(String email, String password) async {
    try {
      Map<String, String> reqFields = {
        'grant_type': 'password',
        'client_id': 'AmplifyApi',
        'client_secret': AppConstants.clientSecret,
        'username': email,
        'password': password
      };
      BaseResModel baseRes = await doMultipartReqPost(
          '$loginBaseUrl/connect/token', reqFields,
          headers: {'Access-Control-Allow-Origin': '*'});
          print({baseRes.data});
      return LoginRes.fromJson(baseRes.data);
    } catch (e) {
      rethrow;
    }
  }
}
