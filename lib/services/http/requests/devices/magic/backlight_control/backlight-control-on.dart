import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-backlight-control.dart';

backlightOn(MagicDeviceModel device) async {
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
