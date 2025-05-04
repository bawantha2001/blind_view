import 'package:dio/dio.dart';

class ErrorHandler{

  static void handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        print('⏱️ Connection timeout');
        break;
      case DioExceptionType.receiveTimeout:
        print('📥 Receive timeout');
        break;
      case DioExceptionType.badResponse:
        print('🚫 Bad response: ${e.response?.statusCode}');
        break;
      default:
        print('❌ Dio Error: ${e.message}');
    }
  }

}