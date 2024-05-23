import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class MockInterceptor extends Interceptor {
  static const _jsonDir = 'assets/json/';
  static const _jsonExtension = '.json';

  // Change this value to simulate a delay in the response.
  static const _fakeTimeout = 500;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final mockResponse = await _loadResponse(options.path, options.method);
    await Future.delayed(const Duration(milliseconds: _fakeTimeout));
    handler.resolve(mockResponse);
  }

  Future<Response> _loadResponse(String path, String method) async {
    final response = await _loadJson(path, method);
    return Response(
      requestOptions: RequestOptions(path: path),
      data: response,
      statusCode: 201, // Change this value to simulate a different status code.
    );
  }

  Future _loadJson(String path, String method) async {
    final fullPath = '$_jsonDir$path/$method$_jsonExtension';
    final jsonString = await rootBundle.loadString(fullPath);
    return json.decode(jsonString);
  }
}
