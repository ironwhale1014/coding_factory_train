import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/secure_storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage));

  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  // 요청을 보낼때
  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
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
    logger.d(
        "[RESPONSE] ${response.requestOptions.method} ${response.requestOptions
            .uri}");

    return super.onResponse(response, handler);
  }

  // 에러가 났을때
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401에러는 토큰에 문제 있을때 발생함
    // accessToken문제로 에러가 날때 토큰을 재발급 받아 제대로ㅜ된 응답을 보여주는 로직
    // 다른 에러는 그냥 에러를 보냄
    logger.e(err.requestOptions.method);
    logger.e(err.requestOptions.uri);

    final refreshToken = await storage.read(key: REFRESH_TOKEN);

    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post("$ip/auth/token",
            options:
            Options(headers: {"authorization": "Bearer $refreshToken"}));
        final accessToken = resp.data["accessToken"];

        final options = err.requestOptions;

        options.headers.addAll({"authorization": "Bearer $accessToken"});

        await storage.write(key: ACCESS_TOKEN, value: accessToken);

        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioException catch (e) {
        handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
