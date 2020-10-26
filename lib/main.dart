
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'helper/Palette.dart';
import 'helper/Router.dart';
import 'helper/route_constant.dart';
import 'language/app_translations_delegate.dart';
import 'language/application.dart';

void main() {
  runApp(
      Phoenix(
        child: MyApp(),
      ),

      );
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  AppTranslationsDelegate _newLocaleDelegate;
  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryDark));
    return MaterialApp(
      onGenerateRoute: Routerr.generateRoute,
      initialRoute: splashScreen,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      localizationsDelegates: [
      _newLocaleDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      supportedLocales: [
        const Locale("en", ""),
        const Locale("es", ""),
        const Locale("hi", ""),
      ],

      theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: primaryColor,
          primaryColor: primaryColor),
    );
  }
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
