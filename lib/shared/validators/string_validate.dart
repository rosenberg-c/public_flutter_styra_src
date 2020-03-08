import 'package:flutter_styra/screens/devices/devices.dart';

bool stringIsValidIp(String value) {
  Pattern pattern = r'^\d+(?:\.\d+)?$';
  RegExp regex = new RegExp(pattern);
  if (value.isEmpty) {
    return false;
  }
  if (!regex.hasMatch(value)) return true;
  return false;
}

bool stringIsValidInt(String value) {
  try {
    final _ = int.parse(value);
    return true;
  } catch (e) {}
  return false;
}

bool stringIsValidDevice(String value) {
  if (DeviceItems.energenie == value || DeviceItems.magic == value) {
    return true;
  }

  return false;
}

validateInputInt(val) {
  try {
    int _ = int.parse(val);
    return true;
  } catch (e) {
    print("Could not parse string to int");
    return false;
  }
}

validRequestPort(val) {
  try {
    int _ = int.tryParse(val);
    if (_ == 5000) {
      return true;
    }
  } catch (e) {
    print("Could not parse string to int");
    return false;
  }
  return false;
}

validWeight(val) {
  try {
    int _ = int.tryParse(val);
    return true;
  } catch (e) {
    print("Could not parse string to int");
    return false;
  }
}

validInputName(val) {
  if (!val.isEmpty) {
    return true;
  }
  return false;
}
