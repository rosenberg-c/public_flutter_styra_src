import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/services/auth/auth_service.dart';
import 'package:flutter_styra/services/storage/tied/user_concatenated_services.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:flutter_styra/shared/widgets/modal_progress/modal_progress_wrapper.dart';
import 'package:provider/provider.dart';

import '../build_app_name.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  final Function setLoading;
  final bool loading;

  Register({this.toggleView, this.setLoading, this.loading});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _pwdCtrl = TextEditingController();
  TextEditingController _errorCtrl = TextEditingController();

  EdgeInsets _rowInsets = EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0);

  _emailValidator(val) {
    return val.isEmpty ? Strings().ui.fields.email.registerValidate : null;
  }

  _emailOnChange(val) {
    setState(() => _emailCtrl.text = val.trim());
  }

  _pwdValidator(val) {
    return val.length < 6
        ? Strings().ui.fields.password.registerValidate
        : null;
  }

  _pwdOnChange(val) {
    setState(() => _pwdCtrl.text = val.trim());
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
        initialValue: _emailCtrl.text,
        obscureText: false,
        validator: (val) => _emailValidator(val),
        onChanged: (val) => _emailOnChange(val),
        decoration: _decoration(
          context: context,
          label: Strings().ui.fields.email.label,
          hint: Strings().ui.fields.email.registerHint,
        ),
      ),
    );
  }

  _buildPasswordField() {
    return _padding(
      child: TextFormField(
        initialValue: _emailCtrl.text,
        obscureText: true,
        validator: (val) => _pwdValidator(val),
        onChanged: (val) => _pwdOnChange(val),
        decoration: _decoration(
            context: context,
            label: Strings().ui.fields.password.label,
            hint: Strings().ui.fields.password.registerHint),
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
            child: Text(Strings().app.auth.register.title),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                setState(() => widget.setLoading(true));

                final result = await TiedServicesUser().registerFirebaseUser(
                  auth: _auth,
                  email: _emailCtrl.text,
                  pwd: _pwdCtrl.text,
                );

                if (result == null) {
                  widget.setLoading(false);
                  setState(() {
                    _errorCtrl.text =
                        Strings().error.errors.other.registerError;
                  });
                  return;
                }

                await TiedServicesUser().tieUserToDatabase(
                  user: result,
                );
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
      child: Center(
        child: Text(
          _errorCtrl.text,
          style: TextStyle(
              color: Provider.of<ThemeService>(context).error, fontSize: 14.0),
        ),
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
              SizedBox(
                height: 20.0,
              ),
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
