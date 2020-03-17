import 'package:flutter/material.dart';

abstract class UserDatabaseInterface {
  Future createUser({@required Map<String, dynamic> map});

  Future readUser();

  Future deleteUser();
}
