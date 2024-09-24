import 'package:amplify/data/services/storage_service.dart';
import 'package:get_storage/get_storage.dart';

class ContextHandler {
  final box = GetStorage('amplify');
  String logoKey = "LOGO_PATH";
  static final ContextHandler _singleton = ContextHandler._internal();

  static ContextHandler getInstance() {
    return _singleton;
  }

  ContextHandler._internal();

  Future<String?> getLogoUrl() {
    return StorageService().getString(logoKey);
  }

  void setAppLogo(String? logoPath) {
    box.write(logoKey, logoPath);
    StorageService().setString(logoKey, logoPath ?? '');
  }
}
