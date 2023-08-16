import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/common/model/cursorpagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_pram.dart';
import 'package:coding_factory_train/common/repository/pagination_repository.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final Dio dio = ref.watch(dioProvider);
  final String baseUrl = "$serverIp/restaurant";

  return RestaurantRepository(dio, baseUrl: baseUrl);
});

@RestApi()
abstract class RestaurantRepository
    implements PaginationRepository<RestaurantModel> {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @override
  @GET("/")
  @Headers({ACCESS_TOKEN: "true"})
  Future<CursorPagination<RestaurantModel>> paginate(
      {@Queries() PaginationParam paginationParam = const PaginationParam()});
}
