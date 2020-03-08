import 'package:intl/intl.dart';

class FieldPassword {
  String get label {
    return Intl.message('Password', name: 'FieldPassword_label', desc: '');
  }

  String get signInValidate {
    return Intl.message('Provide your password',
        name: 'FieldPassword_signInValidate', desc: '');
  }

  String get registerValidate {
    return Intl.message('Provide an password 6+ chars long',
        name: 'FieldPassword_registerValidate', desc: '');
  }

  String get signInHint {
    return Intl.message('Your password',
        name: 'FieldPassword_signInHint', desc: '');
  }

  String get registerHint {
    return Intl.message('Enter a password',
        name: 'FieldPassword_registerHint', desc: '');
  }
}
