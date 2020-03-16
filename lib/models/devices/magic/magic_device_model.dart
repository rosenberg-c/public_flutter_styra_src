import 'package:flutter/foundation.dart';
import 'package:flutter_styra/models/devices/devices.dart';
import 'package:flutter_styra/shared/util-map.dart';

class MagicDeviceModel extends DeviceModel {
  String id = "";
  @override
  String name;
  String host;
  int mmPort;
  int requestPort;
  @override
  String type;
  int _weight;

  MagicDeviceModel({
    String id,
    @required String name,
    @required String host,
    mmPort = 0,
    @required int requestPort,
    String type = DeviceItems.magic,
    int weight,
  }) {
    this.id = id;
    this.name = name;
    this.host = host;
    this.mmPort = mmPort;
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

  String get http {
    return 'http://${host}:${mmPort}';
  }

  String get https {
    return 'https://${host}:${mmPort}';
  }

  static MagicDeviceModel fromMap({Map<String, dynamic> map}) {
    return MagicDeviceModel(
      id: getKey(map, "id", ""),
      name: getKey(map, "name", ""),
      host: getKey(map, "host", ""),
      mmPort: getKey(map, "mmPort", 0),
      requestPort: getKey(map, "requestPort", 0),
      type: getKey(map, "type", ""),
      weight: getKey(map, "weight", 100),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'host': host,
      'mmPort': mmPort,
      'requestPort': requestPort,
      'type': type,
      'weight': _weight,
    };
  }
}
