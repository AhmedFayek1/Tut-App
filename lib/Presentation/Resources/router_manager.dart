import 'package:flutter/material.dart';
import 'package:tut_app/App/dependency_injection.dart';
import 'package:tut_app/Presentation/On_Boardings/On_Boarding_View/on_boarding.dart';
import '../Forgot_Password/View/forgot_password_screen.dart';
import '../Home/main_home.dart';
import '../Login/View/login_screen.dart';
import '../Register/View/register_screen.dart';
import '../Splash/splash_screen.dart';
import '../Store_Details/store_details_screen.dart';

class AppRoutes
{
  static const String splash = "/";
  static const String onboarding = "/onboarding";
  static const String login = "/login";
  static const String register = "/register";
  static const String forgotPassword = "/forgotPassword";
  static const String home = "/home";
  static const String storeDetail = "/storeDetail";
}

class RouterManager
{
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch (settings.name)
    {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case AppRoutes.login:
        initLoginModules();
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        initRegisterModules();
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.forgotPassword:
        initForgotPasswordModules();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppRoutes.home:
        initHomeModules();
        return MaterialPageRoute(builder: (_) => MainScreen());
      case AppRoutes.storeDetail:
        initStoreDetailsModules();
        return MaterialPageRoute(builder: (_) => const StoreDetailsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}