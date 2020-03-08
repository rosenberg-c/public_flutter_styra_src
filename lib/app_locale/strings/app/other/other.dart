import 'package:intl/intl.dart';

class Titles {
  String get device {
    return Intl.message("Device", name: 'Titles_device', desc: '');
  }

  String get edit {
    return Intl.message("Edit", name: 'Titles_edit', desc: '');
  }

  String get home {
    return Intl.message("Home", name: 'Titles_home', desc: '');
  }

  String get time {
    return Intl.message("Time", name: 'Titles_time', desc: '');
  }

  String get remote {
    return Intl.message("Remote", name: 'Titles_remote', desc: '');
  }
}

class HelpText {
  String get addDevice {
    return Intl.message("Use the menu in the upper right to add a device!",
        name: 'HelpText_addDevice', desc: '');
  }
}

class Other {
  final titles = Titles();
  final help = HelpText();
}
