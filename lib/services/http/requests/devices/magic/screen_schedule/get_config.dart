import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/models/devices/magic/magic_schedule_config.dart';
import 'package:flutter_styra/services/http/http_service.dart';
import 'package:flutter_styra/services/http/requests/devices/magic/screen_schedule/config_screen.dart';

Future getScreenScheduleConfig(MagicDeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      MagicRequestURLs.getConfig,
    );

    return MagicScheduleModel.fromMap(map: response);
  } catch (e) {
    print('Error in ${getScreenScheduleConfig}');
  }
  print("Return Empty ${getScreenScheduleConfig}");
  return MagicScheduleModel.empty();
}
