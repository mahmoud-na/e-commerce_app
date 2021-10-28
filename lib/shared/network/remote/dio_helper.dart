import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init({required String baseUrl}) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
     Map<String, dynamic>? query,
    String lang = 'en',
    String? authorization,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': authorization,
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String authorization = '',
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': authorization,
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
