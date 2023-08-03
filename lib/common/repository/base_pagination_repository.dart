import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/model_with_id.dart';
import 'package:coding_factory_train/common/model/pagination_prams.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate(
      {PaginationParams paginationParams = const PaginationParams()});
}
