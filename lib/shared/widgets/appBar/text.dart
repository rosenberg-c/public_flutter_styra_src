import 'package:flutter/widgets.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:provider/provider.dart';

class AppBarText extends StatelessWidget {
  final String string;

  AppBarText({@required this.string});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeService>(context);
    return Container(
        child: Text(
      string,
      style: TextStyle(color: theme.appBarTextBtnColor),
    ));
  }
}
