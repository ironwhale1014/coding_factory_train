import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_param.dart';
import 'package:coding_factory_train/common/provider/pagination_provider.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_provider.g.dart';

@riverpod
RestaurantModel? gRestaurantDetail(GRestaurantDetailRef ref,
    {required String id}) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhere((element) => element.id == id);
}

final restaurantProvider =
    StateNotifierProvider<RestaurantNotifier, CursorPaginationBase>((ref) {
  return RestaurantNotifier(
      repository: ref.watch(restaurantRepositoryProvider));
});

class RestaurantNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantNotifier({required super.repository});

  Future<void> getDetail({required String id}) async {
    if (state is! CursorPagination) {
      await paginate();
    }
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final resp = await repository.getRestaurantDetail(id: id);

    state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? resp : e)
            .toList());
  }
}
