import 'package:coding_factory_train/common/model/login_response.dart';
import 'package:coding_factory_train/common/model/token_response.dart';
import 'package:coding_factory_train/common/util/data_util.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  // /auth
  final String baseUrl;
  final Dio dio;

  AuthRepository({required this.baseUrl, required this.dio});

  Future<LoginResponse> login({required String id, required String pw}) async {
    String encodeIDPW = DataUtils.encodeBase64("$id:$pw");

    final resp = await dio.post("$baseUrl/login",
        options: Options(headers: {"authorization": "Basic $encodeIDPW"}));

    return LoginResponse.fromJson(resp.data);
  }

  Future<TokenResponse> token() async {
    final resp = await dio.post("$baseUrl/token",
        options: Options(headers: {'refreshToken': "true"}));

    return TokenResponse.fromJson(resp.data);
  }
}
