import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/screens/home/screens/device_add_screen.dart';
import 'package:flutter_styra/screens/settings/settings_page.dart';

enum MenuEnum {
  settings,
  brewSettings,
}

Future _selectItem(BuildContext context, item, userService, uid) async {
  switch (item) {
    case MenuEnum.settings:
      {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SettingsPage(
                    userService: userService,
                  )),
        );
      }
      return;

    case MenuEnum.brewSettings:
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            // Skip directly to add magic device
            // Possibility for different devices
            return DeviceAddScreen(
              uid: uid,
            );
          }),
        );
      }
      return;
  }
}

void showMenuPanel(BuildContext context, didPress, userService, uid) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        children: [
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text(Strings().app.menu.settings.title),
            onTap: () {
              didPress();
              _selectItem(context, MenuEnum.settings, userService, uid);
            },
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text(Strings().app.screens.addDevices.title),
            onTap: () {
              didPress();
              _selectItem(context, MenuEnum.brewSettings, userService, uid);
            },
          ),
        ],
      );
    },
  );
}
