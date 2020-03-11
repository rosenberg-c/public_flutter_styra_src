import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/models/devices/energenie/energenie_schedule_config.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-energenie.dart';

updateEnergenieConfig(
    EnergenieDeviceModel device, EnergenieScheduleConfig delta) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      EnergenieEndpoint.postConfig,
      delta.toMap(),
    );
    return EnergenieScheduleConfig.fromMap(map: response);
  } catch (e) {
    print('Error in ${updateEnergenieConfig}');
    print(e);
  }
  print("Return Empty ${updateEnergenieConfig}");
  return EnergenieScheduleConfig.empty();
}
