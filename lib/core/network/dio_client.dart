import 'package:dio/dio.dart';

class DioClient {
  // final _dio = state.Get.find<Dio>();

  final Dio _dio;
  DioClient(this._dio);

  /// [POST]
  Future<dynamic> post({
    String path = '',
    String? token,
    Map<String, String>? headers,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? bodyRaw,
    Map<String, dynamic>? queryParameters,
    ResponseType? responseType,
  }) async {
    /* if (!await _checkInternetConnection()) {
      throw Exception(['NOT_INTERNET_EXCEPTION']);
    } */

    interceptorHeader(
      headers: headers,
      // token: await StorageService.get(Keys.kTokenSesion),
    );

    try {
      final response = await _dio
          .post(
        path,
        data: bodyRaw ?? FormData.fromMap(formData!),
        options: Options(
          method: 'POST',
          responseType: responseType ?? ResponseType.json,
        ),
        queryParameters: queryParameters,
        
      )
          .timeout(
        _dio.options.connectTimeout ?? const Duration(milliseconds: 30),
        onTimeout: () {
          throw Exception(['TIME_OUT']);
        },
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      }
      // Manejar otros errores de Dio
      throw Exception(e);
    }
  }

  Future<dynamic> put(
      {String path = '',
      String? token,
      Map<String, String>? headers,
      Map<String, dynamic>? formData,
      Map<String, dynamic>? bodyRaw,
      Map<String, dynamic>? queryParameters}) async {
   /*  if (!await _checkInternetConnection()) {
      throw Exception(['NOT_INTERNET_EXCEPTION']);
    } */
    interceptorHeader(
      headers: headers,
      // token: await StorageService.get(Keys.kTokenSesion),
    );
    try {
      final response = await _dio
          .put(path,
              data: bodyRaw,
              options: Options(method: 'PUT'),
              queryParameters: queryParameters)
          .timeout(
        _dio.options.connectTimeout ?? const Duration(milliseconds: 30),
        onTimeout: () {
          throw Exception(['TIME_OUT']);
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      }
      throw Exception(e);
    }
  }

  Future<dynamic> delete(
      {String path = '',
      String? token,
      Map<String, String>? headers,
      Map<String, dynamic>? formData,
      Map<String, dynamic>? bodyRaw,
      Map<String, dynamic>? queryParameters}) async {
   /*  if (!await _checkInternetConnection()) {
      throw Exception(['NOT_INTERNET_EXCEPTION']);
    } */
    interceptorHeader(
      headers: headers,
      // token: await StorageService.get(Keys.kTokenSesion),
    );
    try {
      final response = await _dio
          .delete(path,
              data: bodyRaw,
              options: Options(method: 'DELETE'),
              queryParameters: queryParameters)
          .timeout(
        _dio.options.connectTimeout ?? const Duration(milliseconds: 30),
        onTimeout: () {
          throw Exception(['TIME_OUT']);
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      }
      throw Exception(e);
    }
  }

  /// [GET]
  Future<dynamic> get({
    String path = '',
    //String? token,
    Map<String, dynamic>? bodyRaw,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
   /*  if (!await _checkInternetConnection()) {
      throw Exception(['NOT_INTERNET_EXCEPTION']);
    } */
    interceptorHeader(
      headers: headers,
      //token: await StorageService.get(Keys.kTokenSesion),
    );
    try {
      final response = await _dio
          .get(path,
              options: Options(method: 'GET'), queryParameters: queryParameters)
          .timeout(
              _dio.options.connectTimeout ?? const Duration(milliseconds: 30),
              onTimeout: () {
        throw Exception(['TIME_OUT']);
      });

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      }
      return throw Exception(e);
    }
  }

  void interceptorHeader({
    Map<String, String>? headers,
    String token = "",
  }) {
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
    if (token.isNotEmpty) {
      _dio.options.headers.addAll({"Authorization": "Bearer $token"});
    } else {
      _dio.options.headers.remove("Authorization");
    }
  }
  /* Future<bool> _checkInternetConnection() async {
    try {
      final bool isOnline = html.window.navigator.onLine ?? false;
      return isOnline;
    } catch (e) {
      // Manejar errores
      return false;
    }
  } */
}