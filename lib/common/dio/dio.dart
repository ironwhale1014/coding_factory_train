import 'package:coding_factory_train/common/const/data.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  Dio dio = Dio();
  dio.interceptors.add(CustomInterceptor());
  return dio;
});

class CustomInterceptor extends Interceptor{

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    logger.d("[RESPONSE] $response");
  }

}