import 'package:flutter/widgets.dart';
import 'package:flutter_styra/models/device/device_model.dart';

import 'package:flutter_styra/services/http/http_service.dart';
import 'config-device-control.dart';

deviceShutdown({@required String host, @required int port}) async {
  final response = await endpointPost(
      host, port, DeviceControlEndpoint.shutdownDevice, {"sleep": 5});
  return response;
}
