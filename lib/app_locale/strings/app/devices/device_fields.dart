import 'package:intl/intl.dart';

class DeviceFields {
  String get name {
    return Intl.message('Name: ', name: 'DeviceFields_name', desc: '');
  }

  String get host {
    return Intl.message('Host: ', name: 'DeviceFields_host', desc: '');
  }

  String get requestPort {
    return Intl.message('Request Port: ',
        name: 'DeviceFields_requestPort', desc: '');
  }

  String get type {
    return Intl.message('type: ', name: 'DeviceFields_type', desc: '');
  }

  String get weight {
    return Intl.message('weight: ', name: 'DeviceFields_weight', desc: '');
  }

  String get id {
    return Intl.message('Id: ', name: 'DeviceFields_id', desc: '');
  }
}

class AddDeviceStrings {
  String get validateHost {
    return Intl.message("Enter host",
        name: 'AddDeviceStrings_validateHost', desc: '');
  }

  String get hostLabel {
    return Intl.message("host:", name: 'AddDeviceStrings_hostLabel', desc: '');
  }

  String get validateName {
    return Intl.message("Enter Name",
        name: 'AddDeviceStrings_validateName', desc: '');
  }

  String get nameLabel {
    return Intl.message("name: ", name: 'AddDeviceStrings_nameLabel', desc: '');
  }

  String get validateRequestPort {
    return Intl.message("Enter request port",
        name: 'AddDeviceStrings_validateRequestPort', desc: '');
  }

  String get validateType {
    return Intl.message("Enter type",
        name: 'AddDeviceStrings_validateType', desc: '');
  }

  String get portLabel {
    return Intl.message("port: ", name: 'AddDeviceStrings_portLabel', desc: '');
  }

  String get typeLabel {
    return Intl.message("port: ", name: 'AddDeviceStrings_typeLabel', desc: '');
  }

  String get portRequestLabel {
    return Intl.message("request port: ",
        name: 'AddDeviceStrings_portRequestLabel', desc: '');
  }
}
