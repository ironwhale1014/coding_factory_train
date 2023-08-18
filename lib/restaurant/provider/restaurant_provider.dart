import 'package:coding_factory_train/common/model/cursorpagination_model.dart';
import 'package:coding_factory_train/common/provider/paginate_provider.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final pState = ref.watch(restaurantProvider);

  if (pState is! CursorPagination) {
    return null;
  }

  return pState.data.firstWhere((e) => e.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantProvider, CursorPaginationBase>((ref) {
  final repo = ref.watch(restaurantRepositoryProvider);
  return RestaurantProvider(repository: repo);
});

class RestaurantProvider
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantProvider({required super.repository});

  void getDetail({required String id}) async {
    if (state is! CursorPagination) {
      await paginate();
    }
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final resp = await repository.getDetail(id: id);

    state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => (e.id == id) ? resp : e)
            .toList());
  }
}
