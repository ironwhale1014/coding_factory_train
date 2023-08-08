import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/provider/pagination_provider.dart';
import 'package:coding_factory_train/rating/model/rating_model.dart';
import 'package:coding_factory_train/restaurant/repository/rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingNotifier, CursorPaginationBase, String>((ref, id) {
  final repository = ref.watch(ratingRepositoryProvider(id));
  return RestaurantRatingNotifier(repository: repository);
});

class RestaurantRatingNotifier
    extends PaginationProvider<RatingModel, RatingRepository> {
  RestaurantRatingNotifier({required super.repository});
}
