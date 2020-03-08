import 'package:flutter/material.dart';

//Map<int, Color> _color = {
//  50: Color.fromRGBO(136, 14, 79, .1),
//  100: Color.fromRGBO(136, 14, 79, .2),
//  200: Color.fromRGBO(136, 14, 79, .3),
//  300: Color.fromRGBO(136, 14, 79, .4),
//  400: Color.fromRGBO(136, 14, 79, .5),
//  500: Color.fromRGBO(136, 14, 79, .6),
//  600: Color.fromRGBO(136, 14, 79, .7),
//  700: Color.fromRGBO(136, 14, 79, .8),
//  800: Color.fromRGBO(136, 14, 79, .9),
//  900: Color.fromRGBO(136, 14, 79, 1),
//};

class AppThemeColors {
  //AppThemeColors._(); // this basically makes it so you can instantiate this class
  static const Map<int, Color> black = const <int, Color>{
    50: const Color(0xFFDDDDDD),
    100: const Color(0xFFCCCCCC),
    200: const Color(0xFFAAAAAA),
    300: const Color(0xFF999999),
    400: const Color(0xFF888888),
    500: const Color(0xFF777777),
    600: const Color(0xFF666666),
    700: const Color(0xFF555555),
    800: const Color(0xFF444444),
    900: const Color(0xFF333333)
  };
  static const Map<int, Color> blue = const <int, Color>{
    50: const Color(0xFFeaebf3),
    100: const Color(0xFFc9cce2),
    200: const Color(0xFFa7abce),
    300: const Color(0xFF858aba),
    400: const Color(0xFF6d70ab),
    500: const Color(0xFF56579d),
    600: const Color(0xFF4f4f94),
    700: const Color(0xFF474588),
    800: const Color(0xFF3f3c7b),
    900: const Color(0xFF322b64)
  };

  static const Map<int, Color> green = const <int, Color>{
    50: const Color(0xFFA9EDAC),
    100: const Color(0xFFA2E9A5),
    200: const Color(0xFF8FE292),
    300: const Color(0xFF7CD980),
    400: const Color(0xFF63C566),
    500: const Color(0xFF4CAF50),
    600: const Color(0xFF3AA53E),
    700: const Color(0xFF1C8520),
    800: const Color(0xFF0A790E),
    900: const Color(0xFF065709)
  };

  static const Map<int, Color> red = const <int, Color>{
    50: const Color(0xFFFDE0E3),
    100: const Color(0xFFFFCDD2),
    200: const Color(0xFFEF9A9A),
    300: const Color(0xFFE57373),
    400: const Color(0xFFEF5350),
    500: const Color(0xFFF44336),
    600: const Color(0xFFE53935),
    700: const Color(0xFFD32F2F),
    800: const Color(0xFFC62828),
    900: const Color(0xFFB71C1C)
  };
  static const Map<int, Color> yellow = const <int, Color>{
    50: const Color(0xFFFBF6DC),
    100: const Color(0xFFF3ECC7),
    200: const Color(0xFFECE2B1),
    300: const Color(0xFFE4D89C),
    400: const Color(0xFFDDCE87),
    500: const Color(0xFFD5C571),
    600: const Color(0xFFCEBB5C),
    700: const Color(0xFFC6B147),
    800: const Color(0xFFBFA731),
    900: const Color(0xFFB79D1C)
  };
}

//MaterialColor colorCustom = MaterialColor(0xFF880E4F, AppThemeColors.green);

class SwatchColor {
  static MaterialColor c({mColor}) {
    return MaterialColor(
      mColor[500].value,
      <int, Color>{
        50: mColor[50],
        100: mColor[100],
        200: mColor[200],
        300: mColor[300],
        400: mColor[400],
        500: mColor[500],
        600: mColor[600],
        700: mColor[700],
        800: mColor[800],
        900: mColor[900],
      },
    );
  }
}
