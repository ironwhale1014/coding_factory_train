import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/custom_interceptor.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_param.dart';
import 'package:coding_factory_train/common/repository/pagination_repository.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_repository.g.dart';

@Riverpod(keepAlive: true)
RestaurantRepository restaurantRepository(RestaurantRepositoryRef ref) {
  final String baseUrl = "$serverUrl/restaurant";
  final dio = ref.watch(myDioProvider);
  return RestaurantRepository(dio, baseUrl: baseUrl);
}

@RestApi()
abstract class RestaurantRepository
    implements IPaginationRepository<RestaurantModel> {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @override
  @GET("/")
  @Headers({"accessToken": "true"})
  Future<CursorPagination<RestaurantModel>> paginate(
      // const 필수 쿼리 넣는 법
      {@Queries() PaginationParam paginationParam = const PaginationParam()});

  @GET("/{id}")
  @Headers({"accessToken": "true"})
  Future<RestaurantDetailModel> getRestaurantDetail(
      {@Path() required String id});
}
