import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/models/device/device_mirror_model.dart';
import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/screens/home/grid/devices_grid_builder_tile.dart';
import 'package:flutter_styra/services/storage/concatenated/database/items/item_database_service.dart';
import 'package:flutter_styra/shared/widgets/loading/loading.dart';
import 'package:provider/provider.dart';

class DevicesGridBuilder extends StatefulWidget {
  @override
  _DevicesGridBuilderState createState() => _DevicesGridBuilderState();
}

class _DevicesGridBuilderState extends State<DevicesGridBuilder> {
  @override
  Widget build(BuildContext context) {
    var _response_devices = Provider.of<List<ResponseDevice>>(context);
    if (_response_devices == null) {
      return Loading();
    }

    var devices = [];
    _response_devices.forEach((d) => devices.add(convertFromMap(d)));

    if (devices.length == 0) {
      return ListView(
        children: <Widget>[
          Center(child: Text(Strings().app.other.help.addDevice))
        ],
      );
    }

    devices.sort(
      (device_a, device_b) => device_a.weight.compareTo(
        device_b.weight,
      ),
    );

    return GridView.builder(
      itemCount: devices.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return DeviceGridBuilderTile(
          device: devices[index],
        );
      },
    );
  }
}

convertFromMap(ResponseDevice rDevice) {
  if (rDevice.map["type"] == "magic") {
    return DeviceMirrorModel.fromMap(map: rDevice.map);
  }
  if (rDevice.map["type"] == "energenie") {
    return DeviceModel.fromMap(map: rDevice.map);
  }

  throw Error.safeToString("Type is not supported");
}
