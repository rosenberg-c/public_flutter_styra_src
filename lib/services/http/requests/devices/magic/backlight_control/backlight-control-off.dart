import 'package:flutter_styra/models/device/device_mirror_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-backlight-control.dart';

backlightOff(DeviceMirrorModel device) async {
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
