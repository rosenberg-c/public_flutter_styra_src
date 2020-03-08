import 'package:flutter/material.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';
import 'package:flutter_styra/screens/authenticate/pages/register.dart';
import 'package:flutter_styra/screens/authenticate/pages/sign_in.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:provider/provider.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool _showSignIn = true;
  bool _loading = false;

  void toggleView() {
    setState(() => _showSignIn = !_showSignIn);
  }

  void setLoading(bool load) {
    setState(() => _loading = load);
  }

  _buildAppBar() {
    final theme = Provider.of<ThemeService>(context);
    return AppBar(
      elevation: 0.0,
      title: Text(_showSignIn
          ? Strings().app.auth.signIn.title
          : Strings().app.auth.register.title),
      actions: <Widget>[
        FlatButton.icon(
          icon: Icon(Icons.arrow_forward),
          label: Text(
            _showSignIn
                ? Strings().app.auth.register.title
                : Strings().app.auth.signIn.title,
            style: TextStyle().copyWith(
              color: theme.appBarTextBtnColor,
            ),
          ),
          onPressed: () {
            toggleView();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _showSignIn
          ? SignIn(
              toggleView: toggleView,
              setLoading: setLoading,
              loading: _loading,
            )
          : Register(
              toggleView: toggleView,
              setLoading: setLoading,
              loading: _loading),
    );
  }
}
