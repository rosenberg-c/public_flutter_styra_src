import 'package:flutter_styra/models/devices/energenie/energenie_device_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';
import 'package:flutter_styra/services/http/requests/devices/energenie/socket_schedule/config_schedule.dart';

restartSocketService(EnergenieDeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      EnergenieRequestURLs.restartConfig,
    );
    return response;
  } catch (e) {
    print('Error in ${restartSocketService}');
  }
  print("Return Empty ${restartSocketService}");
  return false;
}
