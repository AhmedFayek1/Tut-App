import 'package:flutter/Material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/Presentation/Resources/language_manager.dart';

const String language = "languageCode";
const String isUserLoggedIn = "isUserLoggedIn";
const String isOnBoardingViewed = "isOnBoardingViewed";


class AppPreferences {
  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  Future<String> getLanguage() async
  {
    String? languageCode = _prefs.getString(language);
    if (languageCode != null && languageCode.isNotEmpty) {
      return languageCode;
    }
    else {
      return Languages.English.getLanguage;
    }
  }

  Future<void> setLanguage() async
  {
    String languageCode = await getLanguage();
    if (languageCode == Languages.English.getLanguage) {
      _prefs.setString(language, Languages.Arabic.getLanguage);
    }
    else {
      _prefs.setString(language, Languages.English.getLanguage);
    }
  }

  Future<Locale> getLocal() async
  {
    String languageCode = await getLanguage();
    if (languageCode == Languages.English.getLanguage) {
      return localEN;
    }
    else {
      return localAR;
    }
  }


  Future<bool> setIsOnBoardingViewed() async
  {
    return await _prefs.setBool(isOnBoardingViewed, true);
  }

  Future<bool> getIsOnBoardingViewed() async
  {
    return _prefs.getBool(isOnBoardingViewed) ?? false;
  }


  Future<bool> setIsUserLoggedIn() async
  {
    return await _prefs.setBool(isUserLoggedIn, true);
  }

  Future<bool> getIsUserLoggedIn() async
  {
    return _prefs.getBool(isUserLoggedIn) ?? false;
  }

  Future<bool> logout() async
  {
    return _prefs.setBool(isUserLoggedIn, false);
  }
}