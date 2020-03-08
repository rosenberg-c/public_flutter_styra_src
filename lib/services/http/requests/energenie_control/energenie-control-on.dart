import 'package:flutter_styra/models/device/device_model.dart';

import '../../http_service.dart';
import 'config-energenie-control.dart';

energenieOn(DeviceModel device, int socket) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      EnergenieControlControl.energenieOn,
      {"sleep": 5, "socket": socket},
    );

    return response;
  } catch (e) {
    print("Error in ${energenieOn}");
    return false;
  }
}
