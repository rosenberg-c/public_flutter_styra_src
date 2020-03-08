import 'package:flutter_styra/models/device/device_model.dart';

import '../../http_service.dart';
import 'config-energenie.dart';

restartEnergenieService(DeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      EnergenieEndpoint.restartConfig,
    );
    return response;
  } catch (e) {
    print('Error in ${restartEnergenieService}');
  }
  print("Return Empty ${restartEnergenieService}");
  return false;
}
