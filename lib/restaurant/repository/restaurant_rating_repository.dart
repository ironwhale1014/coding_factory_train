import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_prams.dart';
import 'package:coding_factory_train/common/repository/base_pagination_repository.dart';
import 'package:coding_factory_train/rating/model/rating_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_rating_repository.g.dart';

@Riverpod(keepAlive: true)
RestaurantRatingRepository gRestaurantRatingRepository(
    GRestaurantRatingRepositoryRef ref,
    {required String id}) {
  final dio = ref.watch(dioProvider);
  return RestaurantRatingRepository(dio, baseUrl: "$ip/restaurant/$id/rating");
}

//ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @override
  @GET("/")
  @Headers({'accessToken': "true"})
  Future<CursorPagination<RatingModel>> paginate(
      {@Queries()
      PaginationParams? paginationParams = const PaginationParams()});
}
