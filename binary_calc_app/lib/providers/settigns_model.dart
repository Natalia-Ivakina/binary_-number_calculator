import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:binary_calc_app/utils/color_palette.dart';
import 'package:binary_calc_app/utils/vibration.dart';
import 'package:binary_calc_app/themes/color_themes.dart';

class SettingsModel with ChangeNotifier {
  bool _isVibrationOn = false;
  Color _currentColor = colorPalette[0];
  ThemeData _currentTheme = CustomTheme.lightTheme;

  bool get isVibrationOn => _isVibrationOn;
  Color get currentColor => _currentColor;
  ThemeData get currentTheme => _currentTheme;

//max dimentions of screen
  final double maxHeight = 950;
  final double maxWidth = 450;

  Future<void> loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isVibrationOn = prefs.getBool('isVibrationOn') ?? false;

    int colorValue = prefs.getInt('currentColor') ?? colorPalette[0].value;
    _currentColor = Color(colorValue);

    int themeIndex = prefs.getInt('currentTheme') ?? 0;
    _currentTheme = _getThemeByIndex(themeIndex);

    notifyListeners();
  }

  void toggleVibration() async {
    await handleVibration(_isVibrationOn);
    _isVibrationOn = !_isVibrationOn;
    notifyListeners();
    _savePreferences();
  }

  void updateColor(Color newColor) async {
    await handleVibration(_isVibrationOn);
    _currentColor = newColor;
    notifyListeners();
    _savePreferences();
  }

  void updateTheme(int themeIndex) async {
    _currentTheme = _getThemeByIndex(themeIndex);
    notifyListeners();
    _savePreferences();
  }

  ThemeData _getThemeByIndex(int index) {
    switch (index) {
      case 1:
        return CustomTheme.blueTheme;
      case 2:
        return CustomTheme.greenTheme;
      case 3:
        return CustomTheme.lilacTheme;
      case 4:
        return CustomTheme.darkTheme;
      default:
        return CustomTheme.lightTheme;
    }
  }

  void _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isVibrationOn', _isVibrationOn);
    prefs.setInt('currentColor', _currentColor.value);
    prefs.setInt('currentTheme', _getThemeIndex(_currentTheme));
  }

  int _getThemeIndex(ThemeData theme) {
    if (theme == CustomTheme.blueTheme) return 1;
    if (theme == CustomTheme.greenTheme) return 2;
    if (theme == CustomTheme.lilacTheme) return 3;
    if (theme == CustomTheme.darkTheme) return 4;
    return 0; // Default to light theme
  }
}
