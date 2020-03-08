import 'package:flutter/widgets.dart';
import 'package:flutter_styra/app_locale/strings/app_strings.dart';

class BuildAppName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[Text(Strings().app.main.title, style: TextStyle().copyWith(fontSize: 24.0),)],
    );
  }
}
