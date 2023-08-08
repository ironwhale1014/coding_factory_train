import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/model_with_id.dart';
import 'package:coding_factory_train/common/model/pagination_param.dart';
import 'package:coding_factory_train/common/repository/pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationProvider<T extends IModelWithId,
        U extends IPaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  PaginationProvider({required this.repository})
      : super(CursorPaginationLoading()) {
    paginate();
  }

  final U repository;

  Future<void> paginate(
      {int count = 20, fetchMore = false, forcedFetch = false}) async {
    try {
      if (state is CursorPagination && !forcedFetch) {
        final pState = state as CursorPagination;
        if (!pState.meta.hasMore) {
          return;
        }
      }

      bool isLoading = state is CursorPaginationLoading;
      bool isFetchMore = state is CursorPaginationFetchMore;
      bool isRefetch = state is CursorPaginationRefetch;

      if (fetchMore && (isLoading || isFetchMore || isRefetch)) {
        return;
      }

      PaginationParam paginationParam = PaginationParam(count: count);

      if (fetchMore) {
        final pState = state as CursorPagination<T>;
        state = CursorPaginationFetchMore(meta: pState.meta, data: pState.data);
        paginationParam.copyWith(after: pState.data.last.id);
      } else {
        if (state is CursorPagination && !forcedFetch) {
          final pState = state as CursorPagination<T>;
          state = CursorPaginationRefetch(meta: pState.meta, data: pState.data);
        } else {
          logger.d('Loading');
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(paginationParam: paginationParam);

      if (fetchMore) {
        final pState = state as CursorPaginationFetchMore<T>;

        state = resp.copyWith(data: [...pState.data, ...resp.data]);
      } else {
        state = resp;
      }
    } catch (e, stack) {
      logger.e(e.toString());
      logger.e(stack);
      CursorPaginationError(message: "No get Data");
    }
  }
}
