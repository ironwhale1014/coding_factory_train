


import 'package:coding_factory_train/common/model/cursorpagination_model.dart';
import 'package:coding_factory_train/common/model/id_with_model.dart';
import 'package:coding_factory_train/common/model/pagination_pram.dart';

abstract class PaginationRepository<T extends IModelWithId>{

  Future<CursorPagination<T>> paginate({PaginationParam paginationParam});
}