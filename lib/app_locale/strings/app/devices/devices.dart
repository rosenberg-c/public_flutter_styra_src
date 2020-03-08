import 'device_fields.dart';
import 'energenie/energenie.dart';
import 'magic/magic.dart';

class Devices {
  final magic = MagicDevice();
  final energenie = EnergenieDevice();
  final fields = DeviceFields();
  final addFields = AddDeviceStrings();

}
