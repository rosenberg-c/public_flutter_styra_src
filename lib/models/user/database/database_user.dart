import 'package:flutter/foundation.dart';

class DatabaseUser {
  final String uid;
  final bool isAdmin;

  DatabaseUser({@required this.uid, @required this.isAdmin});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'isAdmin': isAdmin,
    };
  }

  static DatabaseUser fromMap({@required Map<String, dynamic> map}) {
    return DatabaseUser(uid: map["uid"], isAdmin: map["isAdmin"]);
  }
}
