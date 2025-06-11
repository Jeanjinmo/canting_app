import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeMode _themeMode;
  static const String _themeModeKey = 'themeMode';

  ThemeMode get themeMode => _themeMode;

  /// Constructor
  ThemeModeProvider() : _themeMode = ThemeMode.light;

  /// init untuk main
  Future<void> initTheme() async {
    debugPrint('Thema Pertama sebelum init: $_themeMode');
    await _loadThemeMode();
    debugPrint('Thema sesudah load dari Sharedpreference: $_themeMode');
  }

  void setThemeMode(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      await _saveThemeMode(mode);
      notifyListeners();
    }
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getString(_themeModeKey);
    final loadedTheme = switch (savedThemeMode) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      'system' => ThemeMode.system,
      _ => ThemeMode.light, // default (sama dengan _themeMode awal)
    };
    if (_themeMode != loadedTheme) {
      _themeMode = loadedTheme;
    }
    notifyListeners();
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    });
  }
}
