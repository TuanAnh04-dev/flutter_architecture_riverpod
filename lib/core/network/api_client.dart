import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:px1_mobile/auth/auth_interceptor.dart';

class ApiClient {
  final Dio dio;
  final Ref ref;

  ApiClient(Dio? dio, this.ref) : dio = dio ?? Dio() {
    this.dio.options.baseUrl = 'http://10.234.5.124:7788/api/v2';
    this.dio.options.connectTimeout = const Duration(seconds: 30);
    this.dio.options.receiveTimeout = const Duration(seconds: 30);
    this.dio.interceptors.add(AuthInterceptor(ref));
    this.dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true, error: true));
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }
}
