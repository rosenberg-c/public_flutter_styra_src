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

  Color get appBarTextBtnColor {
    return Colors.white70;
  }

  Color get appBarIconColor {
    return pColor[900];
  }

  Color get bottomNavigationBarSelected {
    return pColor[50];
  }

  Color get bottomNavigationBarUnSelected {
    return pColor[900];
  }

  Color get bottomNavigationBarBackground {
    return pColor[400];
  }

  Color get error {
    return Colors.amber[900];
  }
}
