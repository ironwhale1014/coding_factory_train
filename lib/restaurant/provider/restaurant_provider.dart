import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_prams.dart';
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

  return state.data.firstWhere((e) => e.id == id);
}

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

//CursorPaginationBase로 각 상태를 구분하는 트릭

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({required super.repository});

  Future<void> getDetail({required String id}) async {
    if (state is! CursorPagination) {
      await paginate();
    }
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination; //그냥 모델임

    final resp = await repository.getRestaurantDetail(id: id); //디테일 모델임

    state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => (e.id == id) ? resp : e)
            .toList());
  }
}
