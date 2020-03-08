import 'package:flutter_styra/models/device/device_model.dart';

import '../../http_service.dart';
import 'config-get.dart';

Future<dynamic> getOnline(DeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      GetConfig.online,
    );

//    return response.split(",")[0];
    if (response != null) {
      return true;
    }
    return false;
  } catch (e) {
    print("Error in ${getOnline}");
    return false;
  }
}
