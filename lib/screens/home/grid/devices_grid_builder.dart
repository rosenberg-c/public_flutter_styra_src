import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/screens/home/grid/devices_grid_builder_tile.dart';
import 'package:flutter_styra/shared/widgets/loading/loading.dart';
import 'package:provider/provider.dart';

class DevicesGridBuilder extends StatefulWidget {
  @override
  _DevicesGridBuilderState createState() => _DevicesGridBuilderState();
}

class _DevicesGridBuilderState extends State<DevicesGridBuilder> {
  @override
  Widget build(BuildContext context) {
    var devices = Provider.of<List<DeviceModel>>(context);

    if (devices == null) {
      return Loading();
    }

    if (devices.length == 0) {
      return ListView(
        children: <Widget>[
          Center(child: Text(Strings().app.other.help.addDevice))
        ],
      );
    }

    devices.sort((a, b) => a.weight.compareTo(b.weight));

    return GridView.builder(
        itemCount: devices.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return DeviceGridBuilderTile(
            device: devices[index],
          );
        });
  }
}
