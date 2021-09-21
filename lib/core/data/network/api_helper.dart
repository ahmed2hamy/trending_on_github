import 'dart:convert';

import 'package:dio/dio.dart';

class ApiHelper {
  static Future<Map<String, dynamic>> getData(
    Dio dio, {
    required String endPoint,
    Map<String, dynamic>? body,
  }) async {
    Response response = await dio.get(endPoint, queryParameters: body);
    Map<String, dynamic> data = jsonDecode(response.toString());
    return data;
  }
}
