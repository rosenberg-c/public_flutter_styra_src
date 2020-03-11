import 'package:intl/intl.dart';

class EnergenieOther {
  String get energenieDevice {
    return Intl.message('Energenie',
        name: 'EnergenieOther_energenieDevice', desc: '');
  }
}

class AddEnergenieStrings {
  String get title {
    return Intl.message("Energenie Device",
        name: 'AddEnergenieStrings_title', desc: '');
  }
}

class EnergenieDevice {
  final addEnergenie = AddEnergenieStrings();
  final other = EnergenieOther();
}
