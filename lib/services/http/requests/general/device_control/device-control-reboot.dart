import 'package:flutter/widgets.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-device-control.dart';

deviceReboot({@required String host, @required int port}) async {
  final response = await endpointPost(
      host, port, DeviceControlEndpoint.rebootDevice, {"sleep": 5});
  return response;
}
