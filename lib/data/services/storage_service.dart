// lib/services/storage_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String isLogin = "IS_LOGIN";
  static const String registeredMail = "REGISTERED_MAIL";
  static const String pinToLogin = "ACCESS_CODE";
  static const String accessToken = "ACCESS_TOKEN";
  static const String refreshToken = "REFRESH_TOKEN";
  static const String logoPath = "LOGO_PATH";
  static const String expiryDate = "EXPIRY_DATE";

  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<int> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<String?> hasKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> removeAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
