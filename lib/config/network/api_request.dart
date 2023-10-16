import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:skybase/dev/dev_token.dart';

import 'api_config.dart';
import 'api_exception.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

Map<String, String> headers = {
  HttpHeaders.authorizationHeader: '',
};

/// Base Request for calling API.
/// * Can be modify as needed.
class ApiRequest {
  static final _networkUtils = NetworkUtilsRequest();

  static Future<Response> post({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await _networkUtils.tokenManager(useToken);
    return await _networkUtils.safeFetch(
      () => DioClient.instance.post(
        url,
        data: _networkUtils.setBody(contentType: contentType, body: body),
        options: Options(headers: headers, contentType: contentType),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<Response> get({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await _networkUtils.tokenManager(useToken);
    return await _networkUtils.safeFetch(
      () => DioClient.instance.get(
        url,
        options: Options(headers: headers, contentType: contentType),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<Response> patch({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await _networkUtils.tokenManager(useToken);
    return await _networkUtils.safeFetch(
      () => DioClient.instance.patch(
        url,
        data: _networkUtils.setBody(contentType: contentType, body: body),
        options: Options(headers: headers, contentType: contentType),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<Response> put({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Object? body,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await _networkUtils.tokenManager(useToken);
    return await _networkUtils.safeFetch(
      () => DioClient.instance.put(
        url,
        data: _networkUtils.setBody(contentType: contentType, body: body),
        options: Options(headers: headers, contentType: contentType),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }

  static Future<Response> delete({
    required String url,
    bool useToken = true,
    String? contentType = Headers.jsonContentType,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    await _networkUtils.tokenManager(useToken);
    return await _networkUtils.safeFetch(
      () => DioClient.instance.delete(
        url,
        options: Options(headers: headers),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
    );
  }
}

final class NetworkUtilsRequest with NetworkException {
  Object? setBody({
    required String? contentType,
    required Object? body,
  }) {
    if (contentType == Headers.jsonContentType) {
      return body = jsonEncode(body);
    } else if (contentType == Headers.formUrlEncodedContentType) {
      return body;
    } else if (contentType == Headers.multipartFormDataContentType) {
      (body as Map<String, dynamic>).removeWhere((k, v) => v == null);
      return FormData.fromMap(body);
    } else {
      return null;
    }
  }

  Future<void> tokenManager(bool useToken) async {
    DioClient.setInterceptor();
    // String? token = await SecureStorageManager.instance.getToken();
    if (useToken) {
      headers[HttpHeaders.authorizationHeader] = 'token $gitToken';
    } else {
      headers.clear();
    }
  }

  Future<Response> safeFetch(Future<Response> Function() tryFetch) async {
    try {
      final response = await tryFetch();
      // return ApiResponse.fromJson(response.data);
      return response;
    } on DioException catch (e, stackTrace) {
      debugPrint('Api Request -> $e, $stackTrace');
      throw getErrorException(e);
    } catch (e, stackTrace) {
      debugPrint('Api Request -> $e, $stackTrace');
      rethrow;
    }
  }
}
