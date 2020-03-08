import 'package:flutter/foundation.dart';
import 'package:flutter_styra/models/device/device_model.dart';

abstract class DeviceDatabaseInterface {
  void setupRef({
    @required String root,
    @required String uid,
    @required String collection,
  });

  Future<String> create({@required Map<String, dynamic> device});

  Future update({@required Map<String, dynamic> device});

  Future delete({@required String id});

  Future<DeviceModel> getDevice({@required String id});
}
