import 'package:amplify/data/services/auth_service.dart';
import 'package:amplify/data/services/storage_service.dart';
import 'package:amplify/domain/model/login_res.dart';
import 'package:amplify/util/util.dart';

class AuthRepository {
  final StorageService _storageService = StorageService();
  final AuthService _authRepository = AuthService();

  Future<void> updateLoginStatus(String email, LoginRes? loginRes) async {

    // await _storageService.setBool(StorageService.isLogin, true);
    // await _storageService.setString(
    //     StorageService.accessToken, loginRes?.accessToken ?? '');
    // await _storageService.setString(
    //     StorageService.refreshToken, loginRes?.refreshToken ?? '');
    // await _storageService.setString(
    //     StorageService.registeredMail, maskEmail(email));
  }

  Future<void> setLoginPin(String pin) async {
    await _storageService.setString(
        StorageService.pinToLogin, calculateSHA256(pin));
  }

  Future<bool> checkPin(String pin) async {
    return (await _storageService.getString(StorageService.pinToLogin) == pin);
  }

  Future<bool> isLoggedIn() async {
    return (await _storageService.getBool(StorageService.isLogin) &&
        ((await _storageService.getString(StorageService.accessToken)) !=
            null));
  }

  Future<void> clearLoginDetails() async {
    await _storageService.removeAll();
  }

  Future<LoginRes> login(String email, String password) async {
    return _authRepository.login(email, password);
  }

  Future<bool> authCheck() {
    return isLoggedIn();
  }
}
