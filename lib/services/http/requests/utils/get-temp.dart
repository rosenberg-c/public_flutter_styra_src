import 'package:flutter_styra/models/device/device_model.dart';

import '../../http_service.dart';
import 'config-get.dart';

getTemp(DeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      GetConfig.temp,
    );
    return response;
  } catch (e) {
    print("Error in ${getTemp}");
    return false;
  }
}
