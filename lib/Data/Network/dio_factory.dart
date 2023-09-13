import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tut_app/App/app_preferences.dart';
import 'package:tut_app/App/constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String LANGUAGE = "language";

class DioFactory {

  final AppPreferences _prefs;

  DioFactory(this._prefs);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _prefs.getLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: "Bearer ",
      LANGUAGE: language
    };
    Duration timeOut = const Duration(milliseconds: AppConstants.apiTimeOut);
    dio.options = BaseOptions(
        baseUrl: AppConstants.baseUrl,
        receiveTimeout: timeOut,
        sendTimeout: timeOut,
        headers: headers
    );

    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(
          requestBody: true,
          requestHeader: true,
          responseHeader: true,
          responseBody: true
      ));
    }

    return dio;
  }
}
