import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'App/dependency_injection.dart';
import 'App/my_app.dart';
import 'Presentation/Resources/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await getAppModules();
  runApp(
    EasyLocalization(supportedLocales: [localEN, localAR],
    path: path,
    child: Phoenix(child: MyApp(),),)
  );
}