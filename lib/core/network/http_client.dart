import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lms1/core/utils/constants.dart';
import 'package:lms1/core/utils/user_preferences.dart';
import 'package:restart_app/restart_app.dart';

class HttpClient {
  final Dio dio;
  HttpClient({required this.dio});

  init() {
    setDio();
  }

  setDio() {
    final options = BaseOptions(
      baseUrl: BASEURL,
      connectTimeout: 20000,
      receiveTimeout: 30000,
    );
    dio.options = options;
    dio.interceptors.add(AppInterceptor());
    dio.interceptors.add(LogInterceptor());
  }
}

class AppInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log(options.baseUrl + options.path);
    final accessToken = UserPreferences.userToken;
    if (accessToken == null) {
      return super.onRequest(options, handler);
    }
    options.headers.addAll({
      "Content-Type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $accessToken",
      //"Access": "application/json",
    });
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data['success'].toString() == "false") {
      log(response.data.toString());
      final message = response.data['message'].toString();
      if (message == 'Something is missing' ||
          message == 'Do Not Have the Proper Access' ||
          message == 'Not have the token') {
        log(message);
        //Restart.restartApp();
      }
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);

    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      Restart.restartApp();
    }
  }
}
