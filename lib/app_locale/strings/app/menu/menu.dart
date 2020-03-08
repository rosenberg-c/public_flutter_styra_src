import 'package:intl/intl.dart';

class Settings {
  String get title {
    return Intl.message('Settings', name: 'Settings_title', desc: '');
  }
}

class Device {
  String get title {
    return Intl.message('Device', name: 'Device_title', desc: '');
  }
}

class Menu {
  String get title {
    return Intl.message('Menu', name: 'Menu_title', desc: '');
  }

  final settings = Settings();
  final device = Device();
}
