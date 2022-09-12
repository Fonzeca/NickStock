import 'package:dio/dio.dart';

class Api {
  static Dio _dio = Dio();

  static void configureDio() {
    _dio.options.baseUrl = 'http://192.168.1.3:4747';

    //_dio.options.headers = {"content-type": "application/json"};
  }

  static Future httpGet(String path) async {
    try {
      final resp = await _dio.get(path);
      return resp.data;
    } on DioError catch (error) {
      throw ('Http Get Error: ${error.response}');
    }
  }

  static Future httpPost(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.post(path, data: formData);
      return resp.data;
    } on DioError catch (error) {
      throw ('Http Post Error: ${error.response}');
    }
  }

  static Future httpPut(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } on DioError catch (error) {
      throw ('Http Put Error: ${error.response}');
    }
  }

  static Future httpDelete(String path) async {
    try {
      final resp = await _dio.delete(path);
      return resp.data;
    } on DioError catch (error) {
      throw ('Http Delete Error: ${error.response}');
    }
  }
}
