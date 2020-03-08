import 'alerts/add_magic.dart';
import 'buttons/add.dart';
import 'buttons/ok.dart';
import 'buttons/signIn.dart';
import 'buttons/signOut.dart';
import 'buttons/update.dart';
import 'fields/email.dart';
import 'fields/password.dart';
import 'fields/register.dart';
import 'fields/signIn.dart';

class Fields {
  final signIn = FieldSignIn();
  final register = FieldRegister();
  final email = FieldEmail();
  final password = FieldPassword();
}

class Buttons {
  final signIn = ButtonSignIn();
  final signOut = ButtonSignOut();
  final ok = ButtonOk();
  final add = ButtonAdd();
  final update = ButtonUpdate();
}

class Alerts {
  final addMagic = AlertAddDevice();
}

class StringsUI {
  final buttons = Buttons();
  final alerts = Alerts();
  final fields = Fields();
}
