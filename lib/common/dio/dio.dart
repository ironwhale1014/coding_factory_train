import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/secure/secure_storage.dart';
import 'package:coding_factory_train/common/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final Dio dio = Dio();
  final storage = ref.watch(flutterSecureStorageProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage));

  return dio;
}

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["accessToken"] == "true") {
      final String? accessToken = await storage.read(key: ACCESS_TOKEN);
      options.headers.remove("accessToken");
      options.headers.addAll({"authorization": "Barer $accessToken"});
    }
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final String? refreshToken = await storage.read(key: REFRESH_TOKEN);

    final bool isStatus401 = err.response?.statusCode == 401;
    final bool isRefreshTokenPath = err.requestOptions.uri == "/auth/token";

    if (refreshToken == null) {
      return handler.reject(err);
    }

    if (isStatus401 && !isRefreshTokenPath) {
      try {
        final Dio dio = Dio();

        final resp = await dio.post("$serverUrl/auth/token",
            options:
                Options(headers: {"authorization": "Bearer $refreshToken"}));

        final String accessToken = resp.data["accessToken"];
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
    // TODO: implement onResponse
    logger.d(
        "[Response]: ${response.requestOptions.uri}|| method:${response.requestOptions.method}");
    super.onResponse(response, handler);
  }
}
