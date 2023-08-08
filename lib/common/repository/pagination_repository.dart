import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_param.dart';

abstract class IPaginationRepository<T> {
  Future<CursorPagination<T>> paginate(
      {PaginationParam paginationParam = const PaginationParam()});
}
