import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/screens/devices/energenie/screens/energenie_add/energenie_add.dart';
import 'package:flutter_styra/screens/devices/magic/screens/magic_add/magic_add.dart';

_pushToRoute(BuildContext context, Function routeTo) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => routeTo(),
    ),
  );
}

class DeviceAddScreen extends StatelessWidget {
  final String uid;

  DeviceAddScreen({@required this.uid});

  _setupGestureDetector(context, routeTo, title) {
    return GestureDetector(
      onTap: () {
        _pushToRoute(context, routeTo);
      },
      child: Container(
        color: Colors.grey[100],
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<AddScreenContainer> addDevices = [
      AddScreenContainer(
        widget: AddMagic(uid: this.uid),
        name: Strings().app.devices.magic.addMagic.title,
      ),
      AddScreenContainer(
        widget: AddEnergenie(uid: this.uid),
        name: "Energenie",
      )
    ];

    if (addDevices.length == 1) {
      return addDevices.first.widget;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings().app.screens.addDevices.title),
      ),
      body: ListView(
        children: addDevices.map((w) {
          return _setupGestureDetector(context, () => w.widget, w.name)
              as Widget;
        }).toList(),
      ),
    );
  }
}

class AddScreenContainer {
  final Widget widget;
  final String name;

  AddScreenContainer({@required this.widget, @required this.name});
}
