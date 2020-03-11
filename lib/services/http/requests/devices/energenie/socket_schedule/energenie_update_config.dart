import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/models/energenie/energenie.dart';
import 'package:flutter_styra/services/http/http_service.dart';

import 'config-energenie.dart';

updateEnergenieConfig(DeviceModel device, EnergenieConfigModel delta) async {
  try {
    final response = await endpointPost(
      device.host,
      device.requestPort,
      EnergenieEndpoint.postConfig,
      delta.toMap(),
    );
    return EnergenieConfigModel.fromMap(map: response);
  } catch (e) {
    print('Error in ${updateEnergenieConfig}');
    print(e);
  }
  print("Return Empty ${updateEnergenieConfig}");
  return EnergenieConfigModel.empty();
}
