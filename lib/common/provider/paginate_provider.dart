import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/model/cursorpagination_model.dart';
import 'package:coding_factory_train/common/model/id_with_model.dart';
import 'package:coding_factory_train/common/model/pagination_pram.dart';
import 'package:coding_factory_train/common/repository/pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class PaginationProvider<T extends IModelWithId,
        U extends PaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;

  PaginationProvider({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate(
      {int count = 20,
      bool fetchMore = false,
      bool forcedFetch = false}) async {
    try {
      if (state is CursorPagination && !forcedFetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      bool isLoading = state is CursorPaginationLoading;
      bool isFetchMore = state is CursorPaginationFetchMore;
      bool isReFetch = state is CursorPaginationRefetch;

      if (fetchMore && (isLoading || isFetchMore || isReFetch)) {
        return;
      }

      PaginationParam paginationParam = PaginationParam(count: count);

      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state =
            CursorPaginationFetchMore<T>(meta: pState.meta, data: pState.data);
        paginationParam = paginationParam.copyWith(after: pState.data.last.id);
        logger.d("CursorPaginationFetchMore");
      } else {
        logger.d(state);
        if (state is CursorPagination && !forcedFetch) {
          final pState = state as CursorPagination<T>;
          state = CursorPaginationRefetch(meta: pState.meta, data: pState.data);
          logger.d("CursorPaginationRefetch");
        } else {
          state = CursorPaginationLoading();
          logger.d("CursorPaginationLoading");
        }
      }

      final resp = await repository.paginate(paginationParam: paginationParam);


      if (state is CursorPaginationFetchMore) {
        logger.d(state);
        final pState = state as CursorPaginationFetchMore<T>;
        state = resp.copyWith(data: [...pState.data, ...resp.data]);
        logger.d("state is CursorPaginationFetchMore");
      } else {
        logger.d("state is else");
        state = resp;
        logger.d(state);
      }
    } catch (e) {
      CursorPaginationError(message: "no get data");
    }
  }
}
