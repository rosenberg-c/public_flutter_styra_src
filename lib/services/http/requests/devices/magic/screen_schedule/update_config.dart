import 'package:flutter_styra/models/devices/magic/magic_device_model.dart';
import 'package:flutter_styra/models/devices/magic/magic_schedule_config.dart';
import 'package:flutter_styra/services/http/http_service.dart';
import 'package:flutter_styra/services/http/requests/devices/magic/screen_schedule/config_screen.dart';

updateScreenScheduleConfig(
    MagicDeviceModel device, MagicScheduleModel delta) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      MagicRequestURLs.postConfig,
      delta.toMap(),
    );
    return MagicScheduleModel.fromMap(map: response);
  } catch (e) {
    print('Error in ${updateScreenScheduleConfig}');
  }
  print("Return Empty ${updateScreenScheduleConfig}");
  return MagicScheduleModel.empty();
}
