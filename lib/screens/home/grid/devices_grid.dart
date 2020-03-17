import 'package:flutter/material.dart';
import 'package:flutter_styra/models/devices/devices.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/services/storage/tied/database/devices/item_database_service.dart';
import 'package:provider/provider.dart';

import 'devices_grid_builder.dart';

class DevicesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<DeviceAuthUser>(context);
    final databaseService = DeviceDatabaseService();
    databaseService.setupRef(uid: authUser.uid);

    return StreamProvider<List<DeviceModel>>.value(
      value: databaseService.streamItems,
      child: DevicesGridBuilder(),
    );
  }
}
