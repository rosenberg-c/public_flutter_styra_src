import 'package:flutter/widgets.dart';
import 'package:flutter_styra/services/http/http_service.dart';
import 'package:flutter_styra/services/http/requests/general/device_control/config_device_control.dart';

deviceShutdown({@required String host, @required int port}) async {
  final response = await endpointPost(
      host, port, DeviceRequestURLs.shutdownDevice, {"sleep": 5});
  return response;
}
