import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'custom_interceptor.g.dart';

@riverpod
Dio myDio(MyDioRef ref) {
  final Dio dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.addAll([CustomInterceptor(storage: storage)]);

  return dio;
}

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["accessToken"] == "true") {
      final accessToken = await storage.read(key: ACCESS_TOKEN);
      options.headers.remove(accessToken);
      options.headers.addAll({"accessToken": "Bearer $accessToken"});
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN);

    final bool isRefreshPath = err.requestOptions.uri == "/auth/token";
    final bool isStatus401 = err.response?.statusCode == "401";

    if (refreshToken == null) {
      return handler.reject(err);
    }

    if (isStatus401 && !isRefreshPath) {
      final Dio dio = Dio();
      try {
        final resp = await dio.post("$serverUrl/auth/token",
            options:
                Options(headers: {"authorization": "Bearer $refreshToken"}));

        final accessToken = resp.data["accessToken"];
        await storage.write(key: ACCESS_TOKEN, value: accessToken);

        final option = err.requestOptions;
        option.headers.addAll({"authorization": "Bearer $accessToken"});

        final response = await dio.fetch(option);

        handler.resolve(response);
      } on DioException catch (e) {
        return handler.reject(e);
      }
    }

    handler.reject(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d(
        "[RESPONSE] uri:${response.requestOptions.uri}, method:${response.requestOptions.method}");
    super.onResponse(response, handler);
  }
}
