import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/screens/user/user_page.dart';
import 'package:flutter_styra/services/auth/auth_service.dart';
import 'package:flutter_styra/services/storage/tied/user_concatenated_services.dart';

class SettingsPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  final userService;

  SettingsPage({this.userService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 60.0,
            ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("User"),
              onPressed: () async {
                final concatUser = await TiedServicesUser().getTiedUser(
                  auth: _auth,
                  userService: userService,
                );

                final _userPage = UserPage(
                  concatUser: concatUser,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _userPage,
                  ),
                );
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Sign out"),
              onPressed: () async {
                await _auth.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}
