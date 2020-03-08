import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/screens/home/menu/menu.dart';
import 'package:flutter_styra/services/storage/concatenated/database/users/user_database_service.dart';
import 'package:flutter_styra/shared/widgets/appBar/text.dart';
import 'package:provider/provider.dart';

import 'grid/devices_grid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DeviceAuthUser user = Provider.of<DeviceAuthUser>(context);
    final userService = UserDatabaseService(uid: user.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings().app.main.title),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton(
            child: AppBarText(string: Strings().app.menu.title),
            onPressed: () {
              showMenuPanel(
                  context, () => Navigator.pop(context), userService, user.uid);
            },
          )
        ],
      ),
      body: DevicesGrid(),
    );
  }
}
