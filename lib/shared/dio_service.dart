import 'package:dio/dio.dart';

class DioService {

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://book-crud-service-6dmqxfovfq-et.a.run.app/api',
    headers: {'Accept': 'application/json'},
  ));

  static void setAuthToken(String authToken) {
    _dio.options.headers['Authorization'] = authToken;
  }

  static Dio getInstance() {
    return _dio;
  }
}