import 'package:flutter/material.dart';

abstract class DeviceModel with ChangeNotifier {
  String name;
  String type;
  int weight;
}

class DeviceItems {
  static const String magic = "magic";
  static const String energenie = "energenie";
}
