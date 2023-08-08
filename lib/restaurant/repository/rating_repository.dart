import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_param.dart';
import 'package:coding_factory_train/common/repository/pagination_repository.dart';
import 'package:coding_factory_train/rating/model/rating_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';

import '../../common/dio/custom_interceptor.dart';

part 'rating_repository.g.dart';

// http://127.0.0.1:3000/restaurant/:rid/rating

final ratingRepositoryProvider =
    Provider.family<RatingRepository, String>((ref, id) {
  final dio = ref.watch(myDioProvider);
  return RatingRepository(dio, baseUrl: "$serverUrl/restaurant/$id/rating");
});

@RestApi()
abstract class RatingRepository implements IPaginationRepository<RatingModel> {
  factory RatingRepository(Dio dio, {String baseUrl}) = _RatingRepository;

  @override
  @GET("/")
  @Headers({"accessToken": "true"})
  Future<CursorPagination<RatingModel>> paginate(
      {PaginationParam paginationParam = const PaginationParam()});
}
