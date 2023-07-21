import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_prams.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});

//CursorPaginationBase로 각 상태를 구분하는 트릭

class RestaurantStateNotifier extends StateNotifier<CursorPaginationBase> {
  final RestaurantRepository repository;

  RestaurantStateNotifier({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate();
  }

  void paginate({
    int fetchCount = 20,
    // true면 추가로 더 가져옴, false 새로고침(현재 상태를 덮어 씌움)
    bool fetchMore = false,
    // 강제로  다시 로딩 true CursorPaginationLoading 주입
    bool forceRefech = false,
  }) async {
    try {
      // 상태가 5가지 클래스가 5개여서
      //1. CursorPagination -> 정상적으로 데이터가 있는 상태
      //2. CursorPaginationLoading -> 데이터가 로딩중인 상태 현재 캐시 없음
      //3. CursorPaginationError => 에러가 있는 상태
      //4. CursorPaginationRefetching => 첫번째 페이지부터 다시 데이터를 가져올때
      //5. CursorPaginationFetchMore => 추가 데이터를 paginate 해오라는 요청을 받았을때

      //바로 반환하는 상황
      //1) hasMore = false (기존 상태에서 이미 다음 데이터가 없으면) -> 페이지네이션 함수 실행 할 필요 없음 데이터를 가져온적이 있어야 hasMore가 있음
      //2) 로딩중 - fetchMore: true 데이터가 다 오기 전에 요청하면 또 똑같은 데이터를 받아와서
      //         fetchMore가 아닐때 새로 고침의 의도가 있을 수 있을수 있다.
      if (state is CursorPagination && !forceRefech) {
        final pState = state as CursorPagination;
        if (!pState.meta.hasMore) {
          return;
        }
      }

      // 3가지 로딩 상황
      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationfetchingMore;

      //2번 반환 상황
      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }

      // PaginationParams 생성
      PaginationParams paginationParams = PaginationParams(count: fetchCount);

      //fetchMore 데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationfetchingMore(
            meta: pState.meta, data: pState.data);

        paginationParams =
            paginationParams.copyWith(after: pState.data.last.id);
      }
      //  데이터를 처음부터 가져오는 상황
      else {
        // 만약에 데이터가 있으면 기존 데이터를 보존한채로 fetch(API 요청)를 진행
        if (state is CursorPagination && !forceRefech) {
          final pState = state as CursorPagination;

          state =
              CursorPaginationRefetching(meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp =
          await repository.paginate(paginationParams: paginationParams);

      if (state is CursorPaginationfetchingMore) {
        final pState = state as CursorPaginationfetchingMore;

        //기존 데이터에 새로운 데이터 추가
        state = resp.copyWith(data: [
          ...pState.data,
          ...resp.data,
        ]);
      } else {
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationError(message: "no get Data");
    }
  }
}
