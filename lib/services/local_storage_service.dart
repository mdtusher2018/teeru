import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _tokenKey = 'token';
  static const _rememberMeKey = 'rememberMe';





  // Save token
  Future<void> saveRememberMeToken(bool token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, token);
  }

  // Get token
  Future<bool?> getRememberMeToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey);
  }

  // Remove token (for logout)
  Future<void> removeRememberMeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_rememberMeKey);
  }







  // Save token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Remove token (for logout)
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Clear all preferences (optional)
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
