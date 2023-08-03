import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_rating_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantRatingNotifier extends Notifier<CursorPaginationBase> {
  final RestaurantRatingRepository repository;

  RestaurantRatingNotifier({required this.repository});

  @override
  CursorPaginationBase build() {
    return CursorPaginationLoading();
  }
}
