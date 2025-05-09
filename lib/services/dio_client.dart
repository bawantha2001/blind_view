import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient()=> _instance;

  DioClient._internal(){
    final options = BaseOptions(
      baseUrl: "http://10.174.206.178:8070",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
      headers: {
        'content-type':'application/json',
      }
    );

    dio = Dio(options);

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true
    ));

    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     const token = "your-auth-token";
    //     options.headers['Authorization'] = 'Bearer $token';
    //     return handler.next(options);
    //   },
    // ));
  }

}