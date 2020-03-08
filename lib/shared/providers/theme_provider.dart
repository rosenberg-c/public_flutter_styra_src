import 'package:flutter/widgets.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:provider/provider.dart';

ThemeService themeProvider(BuildContext context) {
  return Provider.of<ThemeService>(context);
}
