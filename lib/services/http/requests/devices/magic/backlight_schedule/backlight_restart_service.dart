import 'package:flutter_styra/models/device/device_model.dart';

import 'package:flutter_styra/services/http/http_service.dart';
import 'config-backlight.dart';

restartBacklightService(DeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      BacklightEndpoint.restartConfig,
    );
    return response;
  } catch (e) {
    print('Error in ${restartBacklightService}');
  }
  print("Return Empty ${restartBacklightService}");
  return false;
}
