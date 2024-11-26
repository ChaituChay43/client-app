import 'package:amplify/data/api_services/base_service.dart';
import 'package:amplify/models/response/profile_res.dart';

class ProfileService extends BaseService {
  Future<ProfileRes> fetchProfile() async {
    try {
      BaseResModel baseRes = await doGet('$baseUrl/profile');
      return ProfileRes.fromJson(baseRes.data);
    } catch (e) {
      rethrow;
    }
  }
}
