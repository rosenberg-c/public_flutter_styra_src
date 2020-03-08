import 'package:flutter_styra/models/user/auth/auth_user.dart';

abstract class AbstractAuthUser {
  Future<String> getUid();

  Future<bool> signInAnon();

  Future<bool> signInWithEmailAndPassword({String email, String password});

  Future<DeviceAuthUser> registerWithEmailAndPassword(
      {String email, String password});

  Future signOut();

  Stream<DeviceAuthUser> get streamAuthUser;
}
