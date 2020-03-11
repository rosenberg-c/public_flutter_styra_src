import 'package:intl/intl.dart';

class MagicOther {
  String get magicDevice {
    return Intl.message('Magic Mirror',
        name: 'MagicOther_magicDevice', desc: '');
  }
}

class MagicFields {
  String get mmPort {
    return Intl.message('MM Port: ', name: 'MagicFields_mmPort', desc: '');
  }

  String get validatePort {
    return Intl.message("Enter MM port",
        name: 'MagicFields_validatePort', desc: '');
  }
}

class AddMagicStrings {
  String get title {
    return Intl.message("Magic Decive",
        name: 'AddMagicStrings_title', desc: '');
  }
}

class MagicDevice {
  final addMagic = AddMagicStrings();
  final other = MagicOther();
  final fields = MagicFields();
}
