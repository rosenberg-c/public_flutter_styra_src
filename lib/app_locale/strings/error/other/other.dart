import 'package:intl/intl.dart';

class ErrorSomething {
  String get title {
    return Intl.message('Oops..', name: 'ErrorSomething_title', desc: '');
  }

  String get message {
    return Intl.message('Something went wrong...',
        name: 'ErrorSomething_message', desc: '');
  }

  String get signInError {
    return Intl.message("User credentials failed",
        name: 'ErrorSomething_signInError', desc: '');
  }

  String get registerError {
    return Intl.message("please provide valid email and password",
        name: 'ErrorSomething_registerError', desc: '');
  }
}
