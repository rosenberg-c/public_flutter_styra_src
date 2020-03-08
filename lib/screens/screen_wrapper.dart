import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/screens/authenticate/authenticate.dart';
import 'package:flutter_styra/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class ScreenWrapper extends StatelessWidget {
  static const route = "screen-wrapper";

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<DeviceAuthUser>(context);

    // Init locales
    Strings().of(context);

    if (authUser == null) {
      return Authenticate();
    } else {
      return HomeScreen();
    }
  }
}
