import 'package:flutter/material.dart';
import 'package:flutter_firbase/services/firebase/database/storage_database_service_factory.dart';
import 'package:flutter_styra/models/device/device_model.dart';
import 'package:flutter_styra/shared/constants/db_keys.dart';

import 'abstract_device_database.dart';


class DeviceDatabaseService implements DeviceDatabaseInterface {
  StorageDatabaseServiceFactory _sDB;
  String _root = "data";
  String _uid;
  String _collection;

  DeviceDatabaseService() {
    _sDB = StorageDatabaseServiceFactory();
  }

  @override
  void setupRef({
    String root = "data",
    @required String uid,
    String collection = DEVICE_DB_REF,
  }) {
    _root = root;
    _uid = uid;
    _collection = collection;
    _sDB.instance.setupStreamRef(root: root, uid: uid, collection: collection);
  }

  @override
  Future<String> create({@required Map<String, dynamic> device}) async {
    final didCreate = await _sDB.instance.createItem(
      root: _root,
      uid: _uid,
      collection: _collection,
      map: device,
    );
    return didCreate;
  }

  @override
  Future delete({@required String id}) async {
    final didDelete = await _sDB.instance.deleteItem(
      root: _root,
      uid: _uid,
      collection: _collection,
      id: id,
    );
    return didDelete;
  }

  @override
  Future update({@required Map<String, dynamic> device}) async {
    String _id = device["id"];
    device.remove("id");
    final didUpdate = _sDB.instance.updateItem(
      root: _root,
      uid: _uid,
      collection: _collection,
      id: _id,
      map: device,
    );
    return didUpdate;
  }

  List<DeviceModel> _fromSnapshotM(List<Map<String, dynamic>> maps) {
    return maps.map((map) => DeviceModel.fromMap(map: map)).toList();
  }

  Stream<List<DeviceModel>> get streamItems {
    return _sDB.instance.streamDBStorage.map(_fromSnapshotM);
  }

  @override
  Future<DeviceModel> getDevice({String id}) async {
    final xx = await _sDB.instance
        .getItem(root: _root, uid: _uid, collection: _collection, id: id);
    print("get");
    print(xx);
    if (xx != null) {
      return DeviceModel.fromMap(map: xx);
    }
    return null;
  }
}
