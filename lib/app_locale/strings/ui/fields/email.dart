import 'package:intl/intl.dart';

class FieldEmail {
  String get label {
    return Intl.message('Email', name: 'FieldEmail_label', desc: '');
  }

  String get signInValidate {
    return Intl.message('Enter your email',
        name: 'FieldEmail_signInValidate', desc: '');
  }

  String get registerValidate {
    return Intl.message('Enter an email',
        name: 'FieldEmail_registerValidate', desc: '');
  }

  String get signInHint {
    return Intl.message('Your email', name: 'FieldEmail_signInHint', desc: '');
  }

  String get registerHint {
    return Intl.message('Enter an email',
        name: 'FieldEmail_registerHint', desc: '');
  }
}
