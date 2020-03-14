import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/services/http/http_service.dart';
import 'package:flutter_styra/services/http/requests/devices/magic/screen_schedule/config_screen.dart';


restartScreenScheduleService(MagicDeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      MagicRequestURLs.restartConfig,
    );
    return response;
  } catch (e) {
    print('Error in ${restartScreenScheduleService}');
  }
  print("Return Empty ${restartScreenScheduleService}");
  return false;
}
