import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/screens/home/screens/device_add_screen.dart';
import 'package:flutter_styra/screens/settings/settings_page.dart';

void showMenuPanel({BuildContext context, closeMenu, userService, uid}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return Column(
        children: [
          _buildSettingsListTile(
            context: ctx,
            closeMenu: closeMenu,
            userService: userService,
            uid: uid,
          ),
          _buildAddDeviceListTile(
            context: ctx,
            closeMenu: closeMenu,
            userService: userService,
            uid: uid,
          ),
        ],
      );
    },
  );
}

_buildAddDeviceListTile({BuildContext context, closeMenu, userService, uid}) {
  return ListTile(
    leading: Icon(Icons.ac_unit),
    title: Text(Strings().app.screens.addDevices.title),
    onTap: () {
      closeMenu();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return DeviceAddScreen(
            uid: uid,
          );
        }),
      );
    },
  );
}

_buildSettingsListTile({BuildContext context, closeMenu, userService, uid}) {
  return ListTile(
    leading: Icon(Icons.ac_unit),
    title: Text(Strings().app.screens.addDevices.title),
    onTap: () {
      closeMenu();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SettingsPage(
              userService: userService,
            );
          },
        ),
      );
    },
  );
}
