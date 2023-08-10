import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/provider/pagination_provider.dart';
import 'package:coding_factory_train/product/model/product_model.dart';
import 'package:coding_factory_train/product/repository/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productProvider =
    StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) {
  return ProductStateNotifier(
      repository: ref.watch(gProductRepositoryProvider));
});

class ProductStateNotifier
    extends PaginationProvider<ProductModel, ProductRepository> {
  ProductStateNotifier({required super.repository});
}
