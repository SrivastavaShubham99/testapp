import 'package:dio/dio.dart';
import 'interceptors.dart';

class ApiService {
  static ApiService? _instance;
  factory ApiService() => _instance ??= ApiService._();

  ApiService._();

  Dio get dio => _dio();

  Dio _dio() {
    final options = BaseOptions(
      baseUrl: "https://flutter.virtualsecretary.in/",
      connectTimeout: 50000,
      receiveTimeout: 30000,
    );
    var dio = Dio(options);
    dio.interceptors.add(requestInterceptor(dio));
    return dio;
  }


}





