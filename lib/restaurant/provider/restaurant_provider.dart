import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_param.dart';
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

class RestaurantNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantNotifier({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate(
      {int fetchCount = 20,
      bool fetchMore = false,

      //true 면 강제로 새로 고침
      bool forceRefetch = false}) async {
    if (state is CursorPagination && (forceRefetch == false)) {
      final pState = state as CursorPagination;
      if (pState.meta.hasMore == false) {
        return;
      }
    }

    bool isLoading = state is CursorPaginationLoading;
    bool isRefetch = state is CursorPaginationRefetch;
    bool isFetchMore = state is CursorPaginationFetchMore;

    if (fetchMore && (isLoading || isRefetch || isFetchMore)) {
      return;
    }

    PaginationParam paginationParam = PaginationParam(count: fetchCount);

    if (fetchMore) {
      final pState = state as CursorPagination;
      state = CursorPaginationFetchMore(meta: pState.meta, data: pState.data);
      paginationParam = paginationParam.copyWith(after: pState.data.last.id);
    }

    final resp = await repository.paginate(paginationParam: paginationParam);

    if (state is CursorPaginationFetchMore) {
      final pState = state as CursorPaginationFetchMore;

      state = resp.copyWith(data: [...pState.data, ...resp.data]);
    } else {
      state = resp;
    }
  }

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
