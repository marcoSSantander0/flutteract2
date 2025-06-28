import 'package:flutter/material.dart';
import '../services/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _currentTheme = 'light';
  double _fontSize = 16.0;
  String _fontFamily = 'Roboto';

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;
  String get currentTheme => _currentTheme;
  double get fontSize => _fontSize;
  String get fontFamily => _fontFamily;

  void setFontSize(double size) {
    _fontSize = size;
    SharedPrefsService.setFontFamily(size.toString());
    notifyListeners();
  }

  void setFontFamily(String family) {
    _fontFamily = family;
    SharedPrefsService.setFontFamily(family);
    notifyListeners();
  }

  void toggleTheme(String theme) {
    _currentTheme = theme;
    _themeMode = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
    SharedPrefsService.setTheme(theme);
    notifyListeners();
  }

  void _loadTheme() async {
    String theme = await SharedPrefsService.getTheme();
    double fontSize = await SharedPrefsService.getFontSize();
    String fontFamily = await SharedPrefsService.getFontFamily();
    _currentTheme = theme;
    _themeMode = theme == 'light' ? ThemeMode.light : ThemeMode.dark;
    _fontSize = fontSize;
    _fontFamily = fontFamily;
    notifyListeners();
  }
}
