import 'package:flutter/widgets.dart';
import 'package:flutter_styra/app_locale/setup/app_locale.dart';

import 'app/strings_app.dart';
import 'error/strings_error.dart';
import 'ui/strings_ui.dart';

class AppStrings {
  final ui = StringsUI();
  final app = StringsApp();
  final error = StringsError();
}

class Strings {
  static final Strings _singleton = Strings._internal();

  factory Strings() {
    return _singleton;
  }

  Strings._internal();

  BuildContext _ctx;

  Strings of(BuildContext context) {
    _ctx = context;
    return Strings();
  }

  StringsUI get ui {
    return AppLocalizations.of(_ctx).appStrings.ui;
  }

  StringsApp get app {
    return AppLocalizations.of(_ctx).appStrings.app;
  }

  StringsError get error {
    return AppLocalizations.of(_ctx).appStrings.error;
  }
}
