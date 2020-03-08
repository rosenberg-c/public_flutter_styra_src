import 'network/network.dart';
import 'other/other.dart';

class Errors {
  final network = ErrorNetwork();
  final other = ErrorSomething();
}

class StringsError {
  final errors = Errors();
}
