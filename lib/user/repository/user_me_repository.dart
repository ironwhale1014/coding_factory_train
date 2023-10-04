import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/user/model/user_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

part 'user_me_repository.g.dart';

final userMeRepositoryProvider = Provider<UserMeRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserMeRepository(dio, baseUrl: '$ip/user/me');
});

@RestApi()
abstract class UserMeRepository {
  factory UserMeRepository(Dio dio, {required String baseUrl}) =
      _UserMeRepository;

  @GET("/")
  @Headers({"accessToken": "true"})
  Future<UserModel> getMe();
}
