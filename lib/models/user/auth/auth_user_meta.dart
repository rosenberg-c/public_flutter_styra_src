import 'package:flutter/foundation.dart';
import 'package:flutter_firbase/models/user/auth_user.dart';

class DeviceUserMeta extends UserMeta {
  @override
  final int creationTime;
  @override
  final int lastSignInTime;

  DeviceUserMeta({
    @required this.creationTime,
    @required this.lastSignInTime,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'creationTime': creationTime,
      'lastSignInTime': lastSignInTime,
    };
  }

  DeviceUserMeta fromMap(Map<String, dynamic> meta) {
    return DeviceUserMeta(
      creationTime: meta["creationTime"],
      lastSignInTime: meta["lastSignInTime"],
    );
  }

  DeviceUserMeta fromAuthMeta({UserMeta meta}) {
    return DeviceUserMeta(
      creationTime: meta.creationTime,
      lastSignInTime: meta.lastSignInTime,
    );
  }
}
