import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/models/energenie/energenie.dart';

import '../../http_service.dart';
import 'config-energenie.dart';

Future getEnergenieConfig(DeviceModel device) async {
  try {
    final response = await endpointGet(
      device.host,
      device.requestPort,
      EnergenieEndpoint.getConfig,
    );

    return EnergenieConfigModel.fromMap(map: response);
  } catch (e) {
    print('Error in ${getEnergenieConfig}');
  }
  print("Return Empty ${getEnergenieConfig}");
  return EnergenieConfigModel.empty();
}
