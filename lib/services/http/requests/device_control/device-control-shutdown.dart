import 'package:flutter_styra/models/device/device_model.dart';

import '../../http_service.dart';
import 'config-device-control.dart';

deviceShutdown(DeviceModel device) async {
  final response = await endpointPost(
      device.host, 5000, DeviceControlEndpoint.shutdownDevice, {"sleep": 5});
  return response;
}
