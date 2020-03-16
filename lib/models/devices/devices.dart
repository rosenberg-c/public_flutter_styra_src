import 'package:flutter/material.dart';
import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/models/response_device.dart';

abstract class DeviceModel with ChangeNotifier {
  String name;
  String type;
  int weight;
}

class DeviceItems {
  static const String magic = "magic";
  static const String energenie = "energenie";
}

convertDeviceFromMap(ResponseDevice rDevice) {
  if (rDevice.map["type"] == DeviceItems.magic) {
    return MagicDeviceModel.fromMap(map: rDevice.map);
  }
  if (rDevice.map["type"] == DeviceItems.energenie) {
    return EnergenieDeviceModel.fromMap(map: rDevice.map);
  }

  throw Error.safeToString("Type is not supported");
}
