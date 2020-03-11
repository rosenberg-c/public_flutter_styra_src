import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-energenie-control.dart';

energenieOff(EnergenieDeviceModel device, int socket) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      EnergenieControlControl.energenieOff,
      {"sleep": 5, "socket": socket},
    );

    return response;
  } catch (e) {
    print("Error in ${energenieOff}");
    return false;
  }
}
