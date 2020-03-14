import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';
import 'package:flutter_styra/services/http/requests/devices/magic/screen_control/config_screen_control.dart';


magicScreenOff(MagicDeviceModel device) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      MagicScreenURLs.screenOff,
      {"sleep": 5},
    );

    return response;
  } catch (e) {
    print("Error in ${magicScreenOff}");
    return false;
  }
}
