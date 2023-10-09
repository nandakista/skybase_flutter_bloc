import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_token_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
final class ApiInterceptors extends ApiTokenManager
    implements QueuedInterceptorsWrapper {
  ApiInterceptors(this._dio);
  final Dio _dio;

  @override
  Future<dynamic> onRequest(options, handler) async {
    if (kDebugMode) {
      debugPrint('');
      debugPrint('# REQUEST');
      debugPrint('--> ${options.method.toUpperCase()} - ${options.uri}');
      debugPrint('Headers: ${options.headers}');
      debugPrint('Query Params: ${options.queryParameters}');
      debugPrint('Body: ${options.data}');
      if (options.data is FormData) {
        debugPrint('Body: ${(options.data as FormData).fields}');
      }
      debugPrint('--> END ${options.method.toUpperCase()}');
    }
    return handler.next(options);
  }

  @override
  Future<dynamic> onResponse(Response response, handler) async {
    if (kDebugMode) {
      debugPrint('');
      debugPrint('# RESPONSE');
      debugPrint('<-- ${(response.requestOptions.uri)}');
      debugPrint('Status Code : ${response.statusCode} ');
      debugPrint('Headers: ${response.headers}');
      debugPrint('Response: ${response.data}');
      debugPrint('<-- END HTTP');
    }
    return super.onResponse(response, handler);
  }

  @override
  Future<dynamic> onError(DioException err, handler) async {
    if (kDebugMode) {
      debugPrint('');
      debugPrint('# ERROR');
      debugPrint('<-- ${err.response?.requestOptions.baseUrl}');
      debugPrint('Status Code : ${err.response?.statusCode} ');
      debugPrint('Error Message : ${err.error} ');
      debugPrint('Error Message : ${err.message} ');
      debugPrint('Error Response Message : ${err.response?.statusMessage} ');
      debugPrint('Response Path : ${err.response?.requestOptions.uri}');
      debugPrint('<-- End HTTP');
    }
    handleToken(
      dio: _dio,
      err: err,
      handler: handler,
    );
  }
}
