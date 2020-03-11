import 'package:flutter/widgets.dart';

import 'package:flutter_styra/services/http/http_service.dart';
import 'config-get.dart';

Future<dynamic> getOnline({@required String host, @required int port}) async {
  try {
    final response = await endpointGet(
      host,
      port,
      GetConfig.online,
    );

//    return response.split(",")[0];
    if (response != null) {
      return true;
    }
    return false;
  } catch (e) {
    print("Error in ${getOnline}");
    return false;
  }
}
