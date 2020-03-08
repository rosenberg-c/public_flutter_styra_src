import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_styra/services/auth/auth_service.dart';
import 'package:flutter_styra/services/storage/concatenated/user_concatenated_services.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  final concatUser;

  UserPage({this.concatUser});

  final AuthService _auth = AuthService();

  _buildActions(context) {
    final theme = Provider.of<ThemeService>(context);
    return FlatButton.icon(
      icon: Icon(Icons.person),
      label: Text(
        "Sign out",
        style: TextStyle(color: theme.appBarTextBtnColor),
      ),
      onPressed: () async {
        await _auth.signOut();
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  }

  _buildCard(ConcatinatedUser user) {
    return Card(
      elevation: 0.0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("UID"),
              trailing: Text(user.uidUser.uid),
            ),
            ListTile(
              title: Text("displayName"),
              trailing: Text(user.authUser.displayName.toString()),
            ),
            ListTile(
              title: Text("Email"),
              trailing: Text(user.authUser.email),
            ),
            ListTile(
              title: Text("isEmailVerified"),
              trailing: Text(user.authUser.isEmailVerified.toString()),
            ),
            ListTile(
              title: Text("isAnonymous"),
              trailing: Text(user.authUser.isAnonymous.toString()),
            ),
            ListTile(
              title: Text("creationTime"),
              trailing: Text(user.authUser.meta.creationTime.toString()),
            ),
            ListTile(
              title: Text("lastSignInTime"),
              trailing: Text(user.authUser.meta.lastSignInTime.toString()),
            ),
            ListTile(
              title: Text("isAdmin"),
              trailing: Text(user.uidUser.isAdmin.toString()),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User"),
        actions: <Widget>[_buildActions(context)],
      ),
      body: ListView(
        children: <Widget>[
          _buildCard(concatUser),
        ],
      ),
    );
  }
}
