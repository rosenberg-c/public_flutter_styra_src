import 'package:flutter_styra/models/backlight/backlight.dart';
import 'package:flutter_styra/models/device/device_mirror_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-backlight.dart';

updateBacklightConfig(
    DeviceMirrorModel device, BacklightConfigModel delta) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      BacklightEndpoint.postConfig,
      delta.toMap(),
    );
    return BacklightConfigModel.fromMap(map: response);
  } catch (e) {
    print('Error in ${updateBacklightConfig}');
  }
  print("Return Empty ${updateBacklightConfig}");
  return BacklightConfigModel.empty();
}
