import 'package:flutter/widgets.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-get.dart';

Future<dynamic> getUptime({@required String host, @required int port}) async {
  try {
    final response = await endpointGet(
      host,
      port,
      GetConfig.uptime,
    );
    return response;
  } catch (e) {
    print("Error in ${getUptime}");
    return "0";
  }
}
