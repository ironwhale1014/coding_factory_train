import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_param.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantNotifier, CursorPaginationBase>((ref) {
  return RestaurantNotifier(
      repository: ref.watch(restaurantRepositoryProvider));
});

class RestaurantNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantNotifier({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 20,
  }) async {
    PaginationParam paginationParam = PaginationParam(count: fetchCount);

    final cursorPagination =
        await repository.paginate(paginationParam: paginationParam);
    state = cursorPagination;
  }
}
