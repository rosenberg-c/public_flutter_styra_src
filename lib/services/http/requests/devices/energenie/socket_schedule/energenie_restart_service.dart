import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-energenie.dart';

restartEnergenieService(EnergenieDeviceModel device) async {
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
