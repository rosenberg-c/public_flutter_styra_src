import 'package:flutter_styra/models/device/device_model.dart';

import '../../http_service.dart';
import 'config-get.dart';

Future<dynamic> getUptime(DeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      GetConfig.uptime,
    );
    return response;
  } catch (e) {
    print("Error in ${getUptime}");
    return "0";
  }
}
