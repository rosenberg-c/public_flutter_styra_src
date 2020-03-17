import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/models/devices/devices.dart';
import 'package:flutter_styra/screens/home/grid/devices_grid_tile_builder.dart';
import 'package:flutter_styra/shared/widgets/loading/loading.dart';
import 'package:provider/provider.dart';

class DevicesGridBuilder extends StatefulWidget {
  @override
  _DevicesGridBuilderState createState() => _DevicesGridBuilderState();
}

class _DevicesGridBuilderState extends State<DevicesGridBuilder> {
  @override
  Widget build(BuildContext context) {
    List<DeviceModel> devices = Provider.of<List<DeviceModel>>(context);
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

    devices.sort(
      (device_a, device_b) => device_a.weight.compareTo(device_b.weight),
    );

    return GridView.builder(
      itemCount: devices.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return DeviceGridTileBuilder(
          device: devices[index],
        );
      },
    );
  }
}
