import 'package:flutter/material.dart';
import 'theme.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void setIsDarkMode(bool darkModeActivated) => _isDarkMode = darkModeActivated;

  late ThemeData _themeData = lightTheme;
  ThemeData getTheme() => _themeData;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    ThemeNotifier();
  }

  // ignore: non_constant_identifier_names
  void ThemeNotifier() {
    if (isDarkMode) {
      print("Dark mode applied");
      _themeData = darkTheme;
      notifyListeners();
    } else {
      print("Light mode applid");
      _themeData = lightTheme;
      notifyListeners();
    }
  }

 

  // void setDarkMode() {
  //   _themeData = darkTheme;
  //   notifyListeners();
  // }

  // void setLightMode() {
  //   _themeData = lightTheme;
  //   notifyListeners();
  // }
}
