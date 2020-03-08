import 'package:flutter_styra/models/backlight/backlight.dart';
import 'package:flutter_styra/models/device/device_model.dart';

import '../../http_service.dart';
import 'config-backlight.dart';

updateBacklightConfig(DeviceModel device, BacklightConfigModel delta) async {
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
    print(e);
  }
  print("Return Empty ${updateBacklightConfig}");
  return BacklightConfigModel.empty();
}
