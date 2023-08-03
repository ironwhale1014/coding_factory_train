import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/model_with_id.dart';
import 'package:coding_factory_train/common/model/pagination_prams.dart';
import 'package:coding_factory_train/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationProvider<T extends IModelWithId,
        U extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  PaginationProvider({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate();
  }

  final U repository;

  Future<void> paginate({
    int fetchCount = 20,
    // true면 추가로 더 가져옴, false 새로고침(현재 상태를 덮어 씌움)
    bool fetchMore = false,
    // 강제로 새로고침 true CursorPaginationLoading 주입
    bool forceRefech = false,
  }) async {
    try {
      // 상태가 5가지 = 클래스 5가지
      //1. CursorPagination -> 정상적으로 데이터가 있는 상태
      //2. CursorPaginationLoading -> 데이터가 로딩중인 상태 현재 캐시 없음
      //3. CursorPaginationError => 에러가 있는 상태
      //4. CursorPaginationRefetching => 첫번째 페이지부터 다시 데이터를 가져올때
      //5. CursorPaginationFetchMore => 추가 데이터를 paginate 해오라는 요청을 받았을때
      // -----------------------------------------------------------------------//

      //바로 반환하는 상황 -> 페이지네이션 함수 실행하지 않고 바로 리턴함
      // 1.hasMore = false // 2. 로딩중

      //1) meta.hasMore = false 일때 더이상 데이터가 없으므로 페이지네이션 함수를 실행할 필요 없음
      // + 데이터를 가져온 적이 있어야 hasMore가 있음 -> CursorPagination 상태다
      // forceRefech false면 강제로 새로고침을 안한다.
      if (state is CursorPagination && !forceRefech) {
        final pState = state as CursorPagination;
        if (!pState.meta.hasMore) {
          return;
        }
      }
      //2) 로딩중 - fetchMore: true 새로운 데이터를 요청 중 데이터가 다 오기 전에 요청하면 또 똑같은 데이터를 받아와서 일부러 페이지네이션 함수 실행 안함
      //         fetchMore가 아닐때는 페이지네이션 함수를 실행 함 why? 새로 고침의 의도가 있을 수 있을수 있다.

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

      //fetchMore 데이터를 추가로 더 가져오는 상황 CursorPaginationfetchingMore
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationfetchingMore<T>(
            meta: pState.meta, data: pState.data);

        paginationParams =
            paginationParams.copyWith(after: pState.data.last.id);
      }
      //  데이터를 처음부터 가져오는 상황
      else {
        // 만약에 데이터가 있으면 기존 데이터를 보존한채로 fetch(API 요청)를 진행 CursorPaginationRefetching
        if (state is CursorPagination && !forceRefech) {
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefetching<T>(
              meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      // 무조건 실행되야 함 그냥 리턴 되는 상황이 아니면 요청을 보내는 곳
      final resp =
          await repository.paginate(paginationParams: paginationParams);

      // 최종 데이터 출력
      if (state is CursorPaginationfetchingMore) {
        final pState = state as CursorPaginationfetchingMore<T>;

        //기존 데이터에 새로운 데이터 추가
        state = resp.copyWith(data: [
          ...pState.data,
          ...resp.data,
        ]);
      } else {
        state = resp;
      }
    } catch (e,stack) {
      logger.e(e);
      logger.e(stack);
      state = CursorPaginationError(message: "no get Data");
    }
  }
}
