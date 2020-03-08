import 'package:flutter_styra/shared/util-map.dart';

class BacklightConfigModel {
  bool autoOff;
  bool autoOn;
  String disableFrom;
  String enableFrom;
  bool ignoreGPIO;
  final String name;
  int updateCycle;

  BacklightConfigModel({
    this.autoOff,
    this.autoOn,
    this.disableFrom,
    this.enableFrom,
    this.ignoreGPIO,
    this.name,
    this.updateCycle,
  });

  static BacklightConfigModel fromMap({Map<String, dynamic> map}) {
    return BacklightConfigModel(
      autoOff: getKey(map, "auto_off", false),
      autoOn: getKey(map, "auto_on", false),
      disableFrom: getKey(map, "disable_from", "00:00:00"),
      enableFrom: getKey(map, "enable_from", "00:00:00"),
      ignoreGPIO: getKey(map, "ignore_gpio", false),
      name: getKey(map, "name", "none"),
      updateCycle: getKey(map, "update_cycle", 60),
    );
  }

  static BacklightConfigModel empty() {
    return BacklightConfigModel.fromMap(map: {});
  }

  Map<String, dynamic> toMap() {
    return {
      'auto_off': autoOff,
      'auto_on': autoOn,
      'disable_from': disableFrom,
      'enable_from': enableFrom,
      'ignore_gpio': ignoreGPIO,
      'name': name,
      'update_cycle': updateCycle,
    };
  }
}
