import 'package:flutter_firbase/services/firebase/database/databases/users/user_database.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/models/user/database/database_user.dart';
import 'package:flutter_styra/services/auth/auth_service.dart';
import 'package:flutter_styra/services/storage/tied/database/users/user_database_service.dart';
import 'package:flutter_styra/shared/constants/db_keys.dart';

class TiedServicesUser {
  Future<DeviceAuthUser> registerFirebaseUser(
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

  Future tieUserToDatabase({DeviceAuthUser user}) async {
    await UserDatabase(
      uid: user.uid,
    ).createUser(
        collection: USERS_DB_REF,
        map: DatabaseUser(uid: user.uid, isAdmin: false).toMap());
  }

  Future<TiedUser> getTiedUser({
    AuthService auth,
    UserDatabaseService userService,
  }) async {
    final authUser = await auth.streamAuthUser.first;
    final userSe = await userService.readUser();

    return TiedUser(
      authUser: authUser,
      uidUser: userSe,
    );
  }
}

class TiedUser {
  final DeviceAuthUser authUser;
  final DatabaseUser uidUser;

  TiedUser({this.authUser, this.uidUser});
}
