import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl:'https://newsapi.org/',
      ),
    );
  }

    static Future<Response>? getData({
    required String url,
    required Map<String, dynamic> query,
  }){
    return dio?.get(
        url,  //Method (Which table will get from)
        queryParameters: query
    );
  }

}