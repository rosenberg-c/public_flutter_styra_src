import 'package:flutter/material.dart';
import 'package:flutter_firbase/services/firebase/database/user_service_factory.dart';
import 'package:flutter_styra/models/user/database/database_user.dart';
import 'package:flutter_styra/services/storage/tied/database/users/abstract_user_database.dart';
import 'package:flutter_styra/shared/constants/db_keys.dart';

class UserDatabaseService implements UserDatabaseInterface {
  UserServiceFactory _uService;

  String _collection = USERS_DB_REF;

  UserDatabaseService({@required String uid}) {
    _uService = UserServiceFactory(collection: _collection, uid: uid);
  }

  @override
  Future createUser({@required Map<String, dynamic> map}) async {
    final didCreateUser =
        await _uService.instance.createUser(collection: _collection, map: map);
    if (didCreateUser == null) {
      throw ("Did not Create user");
    }
    return didCreateUser;
  }

  @override
  Future<DatabaseUser> readUser() async {
    final user = await _uService.instance.readUser(collection: _collection);
    if (user == null) {
      throw ("No database user");
    }
    return DatabaseUser.fromMap(map: user);
  }

  @override
  Future deleteUser() async {
    final didDelete =
        await _uService.instance.deleteUser(collection: _collection);
    if (didDelete == null) {
      throw ("Did not Delete user");
    }
    return didDelete;
  }
}
