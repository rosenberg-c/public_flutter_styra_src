import 'package:flutter_styra/models/device/device_model.dart';

import 'package:flutter_styra/services/http/http_service.dart';
import 'config-backlight-control.dart';

backlightOn(DeviceModel device) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      BacklightControlControl.backlightOn,
      {"sleep": 5},
    );

    return response;
  } catch (e) {
    print("Error in ${backlightOn}");
    return false;
  }
}
