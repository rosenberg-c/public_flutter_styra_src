import 'package:flutter_firbase/services/firebase/database/databases/users/user_database.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/models/user/database/database_user.dart';
import 'package:flutter_styra/services/auth/auth_service.dart';
import 'package:flutter_styra/services/storage/concatenated/database/users/user_database_service.dart';
import 'package:flutter_styra/shared/constants/db_keys.dart';

class ConcatenatedServicesUser {
  Future<DeviceAuthUser> tryRegisterStep1(
      {AuthService auth, String email, String pwd}) async {
    DeviceAuthUser result;
    try {
      result = await auth.registerWithEmailAndPassword(
        email: email,
        password: pwd,
      );
    } catch (e) {
      print("There where a problem.");
    }

    if (result == null) {
      print("Register Error");
      return null;
    }
    return result;
  }

  Future tryRegisterStep2({DeviceAuthUser user}) async {
    await UserDatabase(
      uid: user.uid,
    ).createUser(
        collection: USERS_DB_REF,
        map: DatabaseUser(uid: user.uid, isAdmin: false).toMap());
  }

  Future<ConcatinatedUser> getConcatUser({
    AuthService auth,
    UserDatabaseService userService,
  }) async {
    final authUser = await auth.streamAuthUser.first;
    print(authUser.toString());
    final userSe = await userService.readUser();

    return ConcatinatedUser(
      authUser: authUser,
      uidUser: userSe,
    );
  }
}

class ConcatinatedUser {
  final DeviceAuthUser authUser;
  final DatabaseUser uidUser;

  ConcatinatedUser({this.authUser, this.uidUser});
}
