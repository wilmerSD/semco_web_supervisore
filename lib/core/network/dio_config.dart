import 'package:app_tasking/core/environment/env.dart';
import 'package:app_tasking/core/network/interceptors/logger_interceptor.dart';
import 'package:dio/dio.dart';

class DioConfig {
  static Dio initialize() {
     final dio = Dio(
        BaseOptions(
          baseUrl: Environment.appConfig["baseUrl"],
          connectTimeout: Duration(
            milliseconds: Environment.appConfig["connectTimeout"],
          ),
          receiveTimeout: Duration(
            milliseconds: Environment.appConfig["receiveTimeout"],
          ),
          responseType: ResponseType.json,
          // headers: {
          //   'Cache-Control': 'no-cache',
          //   'Pragma': 'no-cache',
          //   'Expires': '0',
          //   "Access-Control-Allow-Origin": "*",
          //   "Access-Control-Allow-Headers": "Content-Type, Authorization",
          //   "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS"
          // },
        ),
      );
      dio.interceptors.addAll([
          LoggerInterceptor(),
        ]);
      return dio;
  }
} 