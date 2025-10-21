import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;
  ApiClient(Dio? dio) : dio = dio ?? Dio() {
    this.dio.options.baseUrl = 'http://localhost:7788/api/v2';
    this.dio.options.connectTimeout = const Duration(seconds: 30);
    this.dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }
}
