import 'package:flutter/widgets.dart';

import 'package:flutter_styra/services/http/http_service.dart';
import 'config-get.dart';

getTemp({@required String host, @required int port}) async {
  try {
    final response = await endpointGet(
      host,
      port,
      GetConfig.temp,
    );
    return response;
  } catch (e) {
    print("Error in ${getTemp}");
    return false;
  }
}
