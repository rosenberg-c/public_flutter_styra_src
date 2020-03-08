import 'package:flutter_styra/models/device/device_model.dart';

import '../../http_service.dart';
import 'config-backlight-control.dart';

backlightOff(DeviceModel device) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      BacklightControlControl.backlightOff,
      {"sleep": 5},
    );

    return response;
  } catch (e) {
    print("Error in ${backlightOff}");
    return false;
  }
}
