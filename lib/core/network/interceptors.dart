import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = options.path;
    logger.e(
      '[${options.method}] $requestPath\n'
      'Error type: ${err.error}\n'
      'Error message: ${err.message}\n'
      'Error response: ${err.response}',
    );
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = options.path;
    logger.i(
      '[${options.method}] $requestPath\n'
      'Body: ${jsonEncode(options.data)}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
      'STATUS CODE: ${response.statusCode} \n'
      'STATUS MESSAGE: ${response.statusMessage} \n'
      'Data: ${jsonEncode(response.data)}',
    );
    handler.next(response);
  }
}

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
