import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final repository = RestaurantRepository(dio, baseUrl: "$ip/restaurant");
  return repository;
});

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET("/")
  @Headers({"accessToken": "true"})
  Future<CursorPagination<RestaurantModel>> paginate();

  @GET("/{id}")
  @Headers({"accessToken": "true"})
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
