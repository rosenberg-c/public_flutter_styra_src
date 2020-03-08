import 'package:flutter_firbase/models/user/auth_user.dart';
import 'package:flutter_firbase/services/firebase/auth/auth_service_factory.dart';
import 'package:flutter_styra/models/user/auth/auth_user.dart';
import 'package:flutter_styra/services/auth/abstract_auth_user.dart';

class AuthService implements AbstractAuthUser {
  final _authServiceFactory = AuthServiceFactory().instance;

  @override
  Future<String> getUid() async {
    return _authServiceFactory.getUid();
  }

  @override
  Future<bool> signInAnon() async {
    return _authServiceFactory.signInAnon();
  }

  @override
  Future<bool> signInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    return _authServiceFactory.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<DeviceAuthUser> registerWithEmailAndPassword({
    String email,
    String password,
  }) async {
    final AuthUser result = await _authServiceFactory
        .registerWithEmailAndPassword(email: email, password: password);
    if (result == null) {
      return null;
    }

    return DeviceAuthUser.fromAuthUser(user: result);
  }

  @override
  Future signOut() async {
    return _authServiceFactory.signOut();
  }

  DeviceAuthUser _userFromFirebaseMap(AuthUser user) {
    if (user != null) {
      return DeviceAuthUser.fromAuthUser(user: user);
    }
    return null;
  }

  @override
  Stream<DeviceAuthUser> get streamAuthUser {
    return _authServiceFactory.streamUser.map(_userFromFirebaseMap);
  }
}
