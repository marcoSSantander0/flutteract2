import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user_model.dart';

class SharedPrefsService {
  static const String _themeKey = 'appTheme';
  static const String _fontSizeKey = 'fontSize';
  static const String _fontFamilyKey = 'fontFamily';
  static const String _currentUserKey = 'currentUser';
  static const String _isLoggedInKey = 'isLoggedIn';

  static Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  static Future<String> getTheme() async {
    final prefs = await _prefs;
    return prefs.getString(_themeKey) ?? 'light';
  }

  static Future<void> setTheme(String theme) async {
    final prefs = await _prefs;
    await prefs.setString(_themeKey, theme);
  }

  static Future<double> getFontSize() async {
    final prefs = await _prefs;
    return prefs.getDouble(_fontSizeKey) ?? 16.0;
  }

  static Future<void> setFontSize(double size) async {
    final prefs = await _prefs;
    await prefs.setDouble(_fontSizeKey, size);
  }

  static Future<String> getFontFamily() async {
    final prefs = await _prefs;
    return prefs.getString(_fontFamilyKey) ?? 'Roboto';
  }

  static Future<void> setFontFamily(String font) async {
    final prefs = await _prefs;
    await prefs.setString(_fontFamilyKey, font);
  }

  static Future<void> saveUser(User user) async {
    final prefs = await _prefs;
    String userJson = jsonEncode(user.toJson());
    await prefs.setString(_currentUserKey, userJson);
  }

  static Future<User?> getUser() async {
    final prefs = await _prefs;
    String? userJson = prefs.getString(_currentUserKey);

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }

    return null;
  }

  static Future<void> setLoggedIn(bool isLoggedIn) async {
    final prefs = await _prefs;
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.remove(_currentUserKey);
    await prefs.setBool(_isLoggedInKey, false);
  }
}
