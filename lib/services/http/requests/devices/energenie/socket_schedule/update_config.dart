import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/models/devices/energenie/energenie_schedule_config.dart';
import 'package:flutter_styra/services/http/http_service.dart';
import 'package:flutter_styra/services/http/requests/devices/energenie/socket_schedule/config_schedule.dart';

updateSocketScheduleConfig(
    EnergenieDeviceModel device, EnergenieScheduleConfig delta) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      EnergenieRequestURLs.postConfig,
      delta.toMap(),
    );
    return EnergenieScheduleConfig.fromMap(map: response);
  } catch (e) {
    print('Error in ${updateSocketScheduleConfig}');
    print(e);
  }
  print("Return Empty ${updateSocketScheduleConfig}");
  return EnergenieScheduleConfig.empty();
}
