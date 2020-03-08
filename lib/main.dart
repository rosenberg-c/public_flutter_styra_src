import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_styra/services/auth/auth_service.dart';
import 'package:flutter_styra/services/theme/theme_service.dart';
import 'package:provider/provider.dart';

import 'app_locale/setup/app_locale.dart';
import 'models/user/auth/auth_user.dart';
import 'screens/screen_wrapper.dart';
import 'shared/widgets/splash/splash.dart';

void main() {
  timeDilation = 1.0;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeService theme = ThemeService();

    final authStream = AuthService().streamAuthUser;
    return Provider<ThemeService>.value(
      value: theme,
      child: StreamProvider<DeviceAuthUser>.value(
        value: authStream,
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.materialDelegate,
            AppLocalizations.cupertinoDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: SupportedLocales.supportedLocales,
          localeResolutionCallback:
              (Locale locale, Iterable<Locale> supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode ||
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return locale;
          },
          theme: theme.mThemeData,
          initialRoute: SplashScreen.route,
          routes: {
            SplashScreen.route: (ctx) =>
                SplashScreen(onSuccessRoute: ScreenWrapper.route),
            ScreenWrapper.route: (ctx) => ScreenWrapper()
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
// authStream != null ? ScreenWrapper() :
