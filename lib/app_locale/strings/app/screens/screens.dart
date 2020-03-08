import 'package:intl/intl.dart';

class AddDevices {
  String get title {
    return Intl.message("Add Devices", name: 'AddDevices_title', desc: '');
  }
}

class Screens {
  final addDevices = AddDevices();
}
