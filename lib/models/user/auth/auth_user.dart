import 'package:flutter/foundation.dart';
import 'package:flutter_firbase/models/user/auth_user.dart';

import 'auth_user_meta.dart';

class DeviceAuthUser extends AuthUser {
  @override
  final String uid;
  @override
  final String email;
  @override
  final String displayName;
  @override
  final bool isAnonymous;
  @override
  final bool isEmailVerified;
  @override
  final DeviceUserMeta meta;

  DeviceAuthUser({
    @required this.uid,
    @required this.email,
    @required this.displayName,
    @required this.isAnonymous,
    @required this.isEmailVerified,
    @required this.meta,
  });

  static DeviceAuthUser fromMap({Map<String, dynamic> map}) {
    return DeviceAuthUser(
      uid: map["uid"],
      email: map["email"],
      displayName: map["displayName"],
      isAnonymous: map["isAnonymous"],
      isEmailVerified: map["isEmailVerified"],
      meta: DeviceUserMeta(
        creationTime: map["meta"]["creationTime"],
        lastSignInTime: map["meta"]["lastSignInTime"],
      ),
    );
  }

  static DeviceAuthUser fromAuthUser({AuthUser user}) {
    return DeviceAuthUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      isAnonymous: user.isAnonymous,
      isEmailVerified: user.isEmailVerified,
      meta: DeviceUserMeta(
        creationTime: user.meta.creationTime,
        lastSignInTime: user.meta.lastSignInTime,
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'isAnonymous': isAnonymous,
      'isEmailVerified': isEmailVerified,
      'meta': meta.toMap(),
    };
  }
}
