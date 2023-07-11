import 'dart:ui';

import 'package:coding_factory_train/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  // 요청을 보낼때
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.d(options.uri);

    if (options.headers["accessToken"] == "true") {
      options.headers.remove("accessToken");
      final token = await storage.read(key: ACCESS_TOKEN);
      options.headers.addAll({"authorization": 'Bearer $token'});
    }

    if (options.headers["refreshToken"] == "true") {
      options.headers.remove("refreshToken");
      final token = await storage.read(key: REFRESH_TOKEN);
      options.headers.addAll({"authorization": 'Bearer $token'});
    }

    return super.onRequest(options, handler);
  }

  // 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  // 에러가 났을때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}
