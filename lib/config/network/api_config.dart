import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:skybase/config/app/app_env.dart';
import 'package:skybase/config/network/api_interceptor.dart';
import 'package:skybase/service_locator.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class DioClient {
  static String baseURL = AppEnv.config.baseUrl;
  final Dio _dio =  sl<Dio>();
  static Dio get find => sl<DioClient>()._dio;

  void init() {
    // _dio = Dio;
    _dio.options.baseUrl = baseURL;
    _dio.options.connectTimeout = const Duration(seconds: 60); //60s
    _dio.options.receiveTimeout = const Duration(seconds: 30); //30s
  }

  static setInterceptor(){
    DioClient.find.interceptors.clear();
    DioClient.find.interceptors.add(ApiInterceptors(DioClient.find));
  }
}