import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../intl/messages/messages_all.dart';
import '../strings/app_strings.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      // Locale wont load correctly without this
      Intl.defaultLocale = localeName;

      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  final appStrings = AppStrings();

  static const LocalizationsDelegate<AppLocalizations> materialDelegate =
      _AppLocalizationsDelegate();

  static const LocalizationsDelegate<CupertinoLocalizations> cupertinoDelegate =
      _FallbackCupertinoLocalisationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return SupportedLocales.supportedLocaleLang.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return await AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

class _FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(_FallbackCupertinoLocalisationsDelegate old) => false;
}

class SupportedLocales {
  static final List<String> supportedLocaleLang = ["en", "sv"];
  static final List<String> supportedLocaleCountry = ["US", "SE"];

  static List<Locale> get supportedLocales {
    return [
      Locale(supportedLocaleLang[0], supportedLocaleCountry[0]),
      Locale(supportedLocaleLang[1], supportedLocaleCountry[1]),
    ];
  }
}
