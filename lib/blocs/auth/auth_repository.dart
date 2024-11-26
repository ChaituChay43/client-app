import 'package:amplify/data/api_services/auth_service.dart';
import 'package:amplify/data/api_services/storage_service.dart';
import 'package:amplify/models/response/login_res.dart';
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
    return true;
    // return (await _storageService.getBool(StorageService.isLogin) &&
    //     ((await _storageService.getString(StorageService.accessToken)) !=
    //         null));
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

  Future<void> setClientId(String clientId) async {
    await StorageService().setString('clientId', clientId);
  }

  Future<String?> getClientId() async {
    return await StorageService().getString('clientId');
  }

  Future<String?> fetchClientId() async {
    // Assume you get the clientId from the server or the response after login.
    // Replace this with the actual API call to get the clientId
    return 'a2188ae3-e607-47db-96c0-f0e812d29136'; // This is a placeholder
  }
}
