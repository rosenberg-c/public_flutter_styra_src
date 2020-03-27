import 'package:flutter/material.dart';
import 'package:flutter_styra/services/theme/theme/material/material_factory.dart';

import 'colors/theme_colors.dart';

class ThemeService {
  ThemeData _mThemeData;

  Map<int, Color> _primaryMapColor;
  MaterialColor _primaryColor;

  ThemeService() {
    _primaryMapColor = AppThemeColors.black;
    _primaryColor = SwatchColor.c(mColor: _primaryMapColor);
  }

  set customTheme(ThemeData themeData) {
    _mThemeData = themeData;
  }

  get _getMaterialThemeData {
    if (_mThemeData == null) {
      _mThemeData = MaterialFactory().materialFactory(
        _primaryColor,
        _primaryMapColor,
      );
      return _mThemeData;
    }
    return _mThemeData;
  }

  ThemeData get mThemeData {
    return _getMaterialThemeData;
  }

  MaterialColor get pColor {
    return _primaryColor;
  }

  set pColor(MaterialColor color) {
    _primaryColor = color;
  }

  Color get appBarTextBtnColor {
    return Colors.white70;
  }

  Color get appBarIconColor {
    return pColor.shade900;
  }

  Color get bottomNavigationBarSelected {
    return pColor.shade50;
  }

  Color get bottomNavigationBarUnSelected {
    return pColor.shade900;
  }

  Color get bottomNavigationBarBackground {
    return pColor.shade400;
  }

  Color get error {
    return Colors.amber.shade900;
  }
}
