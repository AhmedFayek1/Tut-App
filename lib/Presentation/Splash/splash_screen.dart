import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tut_app/App/app_preferences.dart';
import 'package:tut_app/Presentation/Resources/constant_manager.dart';
import 'package:tut_app/Presentation/Resources/router_manager.dart';
import '../../App/dependency_injection.dart';
import '../Resources/assets_manager.dart';
import '../Resources/color_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppPreferences appPreferences = instance<AppPreferences>();

  Timer? _timer;

  _startDely() {
    _timer = Timer(const Duration(seconds: ConstantManager.splachScreenDelay), _gotoNextScreen);
  }

  _gotoNextScreen() {
    appPreferences.getIsUserLoggedIn().then((isUserLoggedIn) {
      if(isUserLoggedIn) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
      else
      {
        appPreferences.getIsOnBoardingViewed().then((isOnBoardingViewed) {
          if(isOnBoardingViewed)
            {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            }
          else
            {
              Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
            }
        });
      }
    });

    Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
  }

  @override
  initState() {
    super.initState();
    _startDely();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image(
          image: AssetImage(ImagesManager.splash),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
