import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/App/app_preferences.dart';
import 'package:tut_app/App/dependency_injection.dart';
import 'package:tut_app/Presentation/Resources/router_manager.dart';

import '../Presentation/Resources/theme_manager.dart';

//Singleton Class
class MyApp extends StatefulWidget {
  MyApp._internal();

  int appState = 0;

  static final MyApp _instance = MyApp._internal(); //create instance of MyApp

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      theme: getThemeData(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouterManager.generateRoute,
      initialRoute: AppRoutes.splash,
    );
  }
}
