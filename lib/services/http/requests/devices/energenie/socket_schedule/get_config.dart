import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/models/devices/energenie/energenie_schedule_config.dart';
import 'package:flutter_styra/services/http/http_service.dart';
import 'package:flutter_styra/services/http/requests/devices/energenie/socket_schedule/config_schedule.dart';

Future getSocketScheduleConfig(EnergenieDeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      EnergenieRequestURLs.getConfig,
    );

    return EnergenieScheduleConfig.fromMap(map: response);
  } catch (e) {
    print('Error in ${getSocketScheduleConfig}');
  }
  print("Return Empty ${getSocketScheduleConfig}");
  return EnergenieScheduleConfig.empty();
}
