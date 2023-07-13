import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';

part 'restaurant_repository.g.dart';

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
