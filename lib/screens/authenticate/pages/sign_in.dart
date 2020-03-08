import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/services/auth/auth_service.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/widgets/modal_progress/modal_progress_wrapper.dart';
import 'package:provider/provider.dart';

import '../build_app_name.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  final Function setLoading;
  final bool loading;

  SignIn({this.toggleView, this.setLoading, this.loading});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _currentEmailController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _currentErrorController = TextEditingController();

  EdgeInsets _rowInsets = EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0);

  _emailValidator(val) {
    return val.isEmpty ? Strings().ui.fields.email.signInValidate : null;
  }

  _emailOnChange(val) {
    setState(() => _currentEmailController.text = val.trim());
  }

  _pwdValidator(val) {
    return val.length < 6 ? Strings().ui.fields.password.signInValidate : null;
  }

  _pwdOnChange(val) {
    setState(() => _currentPasswordController.text = val.trim());
  }

  _padding({Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: child,
    );
  }

  _decoration({context, label, hint}) {
    return InputDecoration().copyWith(hintText: hint, labelText: label);
  }

  _buildEmailField() {
    return _padding(
      child: TextFormField(
        initialValue: _currentEmailController.text,
        obscureText: false,
        validator: (val) => _emailValidator(val),
        onChanged: (val) => _emailOnChange(val),
        decoration: _decoration(
          context: context,
          label: Strings().ui.fields.email.label,
          hint: Strings().ui.fields.email.signInHint,
        ),
      ),
    );
  }

  _buildPasswordField() {
    return _padding(
      child: TextFormField(
        initialValue: _currentEmailController.text,
        obscureText: true,
        validator: (val) => _pwdValidator(val),
        onChanged: (val) => _pwdOnChange(val),
        decoration: _decoration(
          context: context,
          label: Strings().ui.fields.password.label,
          hint: Strings().ui.fields.password.signInHint,
        ),
      ),
    );
  }

  _submit() {
    return Padding(
      padding: _rowInsets.copyWith(top: _rowInsets.top + 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            child: Text(Strings().ui.buttons.signIn.label),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                setState(() => widget.setLoading(true));
                dynamic result = await _auth.signInWithEmailAndPassword(
                    email: _currentEmailController.text,
                    password: _currentPasswordController.text);
                if (result == null) {
                  setState(() {
                    _currentErrorController.text =
                        Strings().error.errors.other.signInError;
                    widget.setLoading(false);
                  });
                }
              }
            },
          ),
        ],
      ),
    );
  }

  _buildError() {
    return Padding(
      padding: _rowInsets.copyWith(top: _rowInsets.top + 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            _currentErrorController.text,
            style: TextStyle(
                color: Provider.of<ThemeService>(context).error,
                fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return modalProgressWrapper(
      child: Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 20.0),
              BuildAppName(),
              _buildEmailField(),
              _buildPasswordField(),
              _submit(),
              _buildError(),
            ],
          ),
        ),
      ),
      loading: widget.loading,
    );
  }
}
