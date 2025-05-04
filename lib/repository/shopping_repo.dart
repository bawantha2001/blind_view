
import 'package:blind_view/services/dio_client.dart';
import 'package:blind_view/services/error_handler.dart';
import 'package:dio/dio.dart';

import '../models/item.dart';

class ShoppingRepo{

  final Dio _dio = DioClient().dio;

  Future<Response> getItem() async{
    try{
      final response = await _dio.get("/item");
      return response;
    }on DioException catch(e){
      ErrorHandler.handleError(e);
      rethrow;
    }
  }

}