import 'package:amplify/data/api_services/profile_service.dart';
import 'package:amplify/models/response/profile_res.dart';
import 'package:amplify/util/context_handler.dart';

class ProfileRepository {
  final ProfileService _profileService = ProfileService();

  Future<ProfileRes> fetchProfile() async {
    ProfileRes profileRes = await _profileService.fetchProfile();
    ContextHandler.getInstance()
        .setAppLogo(profileRes.data?.settings?.logoPath);
    return profileRes;
  }
}
