import 'package:coding_factory_train/user/model/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'user_me_repository.g.dart';

@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {required String baseUrl}) =
      _UserMeRepository;

  @GET("/")
  @Headers({"accessToken": "true"})
  Future<UserModel> getMe();
}
