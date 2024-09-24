import 'package:amplify/data/services/base_service.dart';
import 'package:amplify/domain/model/profile_res.dart';

class ProfileService extends BaseService {
  Future<ProfileRes> fetchProfile() async {
    try {
      BaseResModel baseRes = await doGet('$baseUrl/v1/profile');
      return ProfileRes.fromJson(baseRes.response);
    } catch (e) {
      rethrow;
    }
  }
}
