import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/pagination_prams.dart';
import 'package:coding_factory_train/common/repository/base_pagination_repository.dart';
import 'package:coding_factory_train/product/model/product_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../common/const/data.dart';

part 'product_repository.g.dart';

@Riverpod(keepAlive: true)
ProductRepository gProductRepository(GProductRepositoryRef ref) {
  final Dio dio = ref.watch(dioProvider);

  return ProductRepository(dio, baseUrl: "$ip/product");
}

@RestApi()
abstract class ProductRepository
    implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET("/")
  @Headers({"accessToken": "true"})
  Future<CursorPagination<ProductModel>> paginate(
      {PaginationParams paginationParams = const PaginationParams()});
}
