import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/secure/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  Dio dio = Dio();
  final storage = ref.watch(secureStorageProvider);
  dio.interceptors.add(CustomInterceptor(storage: storage));
  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers[ACCESS_TOKEN] == "true") {
      final accessToken = await storage.read(key: ACCESS_TOKEN);
      options.headers.remove("accessToken");
      options.headers.addAll({"authorization": "Bearer $accessToken"});
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    logger.d("ll");
    final refreshToken = await storage.read(key: REFRESH_TOKEN);
    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isState401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == "/auth/token";

    if (isState401 && !isPathRefresh) {
      final Dio dio = Dio();
      try {
        final resp = await dio.post("$serverIp/auth/token",
            options:
                Options(headers: {"authorization": "Bearer $refreshToken"}));

        final accessToken = resp.data[ACCESS_TOKEN];
        await storage.write(key: ACCESS_TOKEN, value: accessToken);

        final options = err.requestOptions;

        options.headers.addAll({"authorization": "Bearer $accessToken"});

        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioException catch (e) {
        handler.reject(e);
      }
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    logger.d("[RESPONSE] $response");
  }
}
