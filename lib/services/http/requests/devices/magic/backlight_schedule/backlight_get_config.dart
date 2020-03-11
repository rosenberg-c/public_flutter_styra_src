import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/models/devices/magic/magic_schedule_config.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-backlight.dart';

Future getBacklightConfig(MagicDeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      BacklightEndpoint.getConfig,
    );

    return MagicScheduleModel.fromMap(map: response);
  } catch (e) {
    print('Error in ${getBacklightConfig}');
  }
  print("Return Empty ${getBacklightConfig}");
  return MagicScheduleModel.empty();
}
