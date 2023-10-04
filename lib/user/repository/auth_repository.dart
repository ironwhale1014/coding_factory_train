import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/common/model/login_response.dart';
import 'package:coding_factory_train/common/model/token_response.dart';
import 'package:coding_factory_train/common/util/data_util.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// final authRepositoryProvider = Provider<AuthRepository>((ref) {
//   final dio = ref.watch(dioProvider);
//
//   return AuthRepository(baseUrl: '$ip/auth', dio: dio);
// });
//
// class AuthRepository {
//   // /auth
//   final String baseUrl;
//   final Dio dio;
//
//   AuthRepository({required this.baseUrl, required this.dio});
//
//   Future<LoginResponse> login({required String id, required String pw}) async {
//     String encodeIDPW = DataUtils.encodeBase64("$id:$pw");
//
//     final resp = await dio.post("$baseUrl/login",
//         options: Options(headers: {"authorization": "Basic $encodeIDPW"}));
//
//     return LoginResponse.fromJson(resp.data);
//   }
//
//   Future<TokenResponse> token() async {
//     final resp = await dio.post("$baseUrl/token",
//         options: Options(headers: {'refreshToken': "true"}));
//     return TokenResponse.fromJson(resp.data);
//   }
// }

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(dio: ref.watch(dioProvider), baseUrl: "$ip/auth");
});

class AuthRepository {
  final Dio dio;
  final String baseUrl;

  AuthRepository({required this.dio, required this.baseUrl});

  Future<LoginResponse> login({required String id, required String pw}) async {
    final serialized = DataUtils.encodeBase64("$id:$pw");

    final resp = await dio.post("$baseUrl/login",
        options: Options(headers: {"authorization": "Basic $serialized"}));

    final LoginResponse loginResponse = LoginResponse.fromJson(resp.data);

    return loginResponse;
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post("$baseUrl/token",
        options: Options(headers: {"refreshToken": "true"}));

    return TokenResponse.fromJson(resp.data);
  }
}
