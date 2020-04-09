import 'package:flutter/foundation.dart';
import 'package:flutter_styra/models/devices/devices.dart';
import 'package:flutter_styra/shared/util-map.dart';

class EnergenieDeviceModel extends DeviceModel {
  String id = "";
  @override
  String name;
  String host;
  int requestPort;
  @override
  String type;
  int _weight;

  EnergenieDeviceModel({
    String id,
    @required String name,
    @required String host,
    @required int requestPort,
    String type = DeviceItems.energenie,
    int weight,
  }) {
    this.id = id;
    this.name = name;
    this.host = host;
    this.requestPort = requestPort;
    this.type = type;
    this._weight = weight != null ? weight : 100;
  }

  setId({id}) {
    this.id = id;
  }

  @override
  int get weight {
    return this._weight;
  }

  static EnergenieDeviceModel fromMap({Map<String, dynamic> map}) {
    return EnergenieDeviceModel(
      id: getKey(map: map, key: "id", defaultVal: ""),
      name: getKey(map: map, key: "name", defaultVal: ""),
      host: getKey(map: map, key: "host", defaultVal: ""),
      requestPort: getKey(map: map, key: "requestPort", defaultVal: 0),
      type: getKey(map: map, key: "type", defaultVal: ""),
      weight: getKey(map: map, key: "weight", defaultVal: 100),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'host': host,
      'requestPort': requestPort,
      'type': type,
      'weight': _weight,
    };
  }
}
