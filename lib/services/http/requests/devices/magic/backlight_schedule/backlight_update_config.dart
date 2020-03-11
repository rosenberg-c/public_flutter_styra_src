import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/models/devices/magic/magic_schedule_config.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-backlight.dart';

updateBacklightConfig(MagicDeviceModel device, MagicScheduleModel delta) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      BacklightEndpoint.postConfig,
      delta.toMap(),
    );
    return MagicScheduleModel.fromMap(map: response);
  } catch (e) {
    print('Error in ${updateBacklightConfig}');
  }
  print("Return Empty ${updateBacklightConfig}");
  return MagicScheduleModel.empty();
}
