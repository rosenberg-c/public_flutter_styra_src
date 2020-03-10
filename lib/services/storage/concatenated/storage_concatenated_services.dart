import 'package:flutter/cupertino.dart';
import 'package:flutter_styra/models/device/device_model.dart';

import 'database/items/item_database_service.dart';

class ConcatenatedServices {
  tryAddMagicDevice({
    @required DeviceDatabaseService deviceDB,
    @required String name,
    @required String host,
    @required String mmPort,
    @required String requestPort,
    @required String type,
    @required String uid,
  }) async {
    final device = DeviceModel(
      name: name,
      host: host,
      mmPort: mmPort,
      requestPort: requestPort,
      type: type,
    );

    await deviceDB.create(device: device.toMap());
  }

  tryAddEnergenieDevice({
    @required DeviceDatabaseService deviceDB,
    @required String name,
    @required String host,
    @required String requestPort,
    @required String type,
    @required String uid,
  }) async {
    final device = DeviceModel(
      name: name,
      host: host,
      requestPort: requestPort,
      type: type,
    );

    await deviceDB.create(device: device.toMap());
  }

  deviceDelete({DeviceDatabaseService deviceDB, uid, magicId}) async {
    await deviceDB.delete(id: magicId);
  }
}
