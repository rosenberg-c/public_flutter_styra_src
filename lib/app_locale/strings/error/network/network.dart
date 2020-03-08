import 'package:intl/intl.dart';

const String name = "ErrorNetwork";

class ErrorNetwork {
  String get unknown {
    return Intl.message('Unknown', name: 'ErrorNetwork_unknown', desc: '');
  }

  String get timeout {
    return Intl.message('Timeout', name: 'ErrorNetwork_timeout', desc: '');
  }

  String get socket {
    return Intl.message('Socket', name: 'ErrorNetwork_socket', desc: '');
  }
}
