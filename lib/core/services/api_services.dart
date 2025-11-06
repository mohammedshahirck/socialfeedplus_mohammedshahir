import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

class ApiService extends GetxService {
  late Dio dio;

  @override
  void onInit() {
    super.onInit();
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com', // mock base
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Optional: log all requests/responses
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<Response?> getRequest(String endpoint) async {
    try {
      final response = await dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      print("❌ Dio error: ${e.message}");
      return null;
    }
  }
}
