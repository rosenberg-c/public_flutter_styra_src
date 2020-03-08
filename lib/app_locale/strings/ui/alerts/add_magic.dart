import 'package:intl/intl.dart';

class AlertAddDevice {
  String get title {
    return Intl.message('Hey there!', name: 'AlertAddDevice_title', desc: '');
  }

  String get content {
    return Intl.message('Please fill out the fields!!!!!',
        name: 'AlertAddDevice_content', desc: '');
  }
}
