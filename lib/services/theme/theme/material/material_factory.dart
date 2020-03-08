import 'package:flutter/material.dart';
import 'package:flutter_styra/services/theme/colors/theme_colors.dart';

class MaterialFactory {
  ThemeData _materialTheme;

  MaterialFactory();

  _init(
    MaterialColor primaryColor,
    Map<int, Color> primaryMapColor,
  ) {
    final buttonColor = primaryColor[800];
    final appBarButtonColor = primaryColor[900];
    final appBar = primaryColor[400];
    final appBarText = Colors.white;
    final appBarFontSize = 18.0;

    final scaffold = primaryColor[50];

    ButtonThemeData buttonThemeData = ButtonThemeData().copyWith(
      buttonColor: buttonColor,
      textTheme: ButtonTextTheme.primary,
    );

    TabBarTheme tabBarTheme = TabBarTheme().copyWith(
      labelColor: buttonColor,
    );

    AppBarTheme appBarTheme = AppBarTheme().copyWith(
      color: appBar,
      textTheme: TextTheme().copyWith(
          title: TextStyle(fontSize: appBarFontSize, color: appBarText)),
      // Cannot set IconThemeData color here, it gets ignored as per design..
      // Setting the color as a visual reminder that this is overridden where app bar is used
      // When ButtonThemeData uses textTheme, the overrides in place WILL GET OVERRIDDEN and the color will be dimmed..
      iconTheme: IconThemeData().copyWith(color: appBarButtonColor),
      // Back button
      actionsIconTheme: IconThemeData().copyWith(),
    );

    return ThemeData(
      textTheme: TextTheme().copyWith(),
      primarySwatch: SwatchColor.c(mColor: primaryMapColor),
    ).copyWith(
      primaryColor: primaryColor,
      bottomAppBarColor: primaryColor,
      appBarTheme: appBarTheme,
      tabBarTheme: tabBarTheme,
      scaffoldBackgroundColor: scaffold,
      buttonTheme: buttonThemeData,
    );
  }

  ThemeData materialFactory(
    MaterialColor primaryColor,
    Map<int, Color> primaryMapColor,
  ) {
    if (_materialTheme == null) {
      _materialTheme = _init(
        primaryColor,
        primaryMapColor,
      );
      return _materialTheme;
    }

    return _materialTheme;
  }
}
