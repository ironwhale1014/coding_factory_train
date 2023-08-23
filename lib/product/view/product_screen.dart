import 'package:coding_factory_train/common/component/pagination_list_view.dart';
import 'package:coding_factory_train/product/component/product_card.dart';
import 'package:coding_factory_train/product/model/product_model.dart';
import 'package:coding_factory_train/product/provider/product_provider.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(itemBuilder: (context,index,model){
      return ProductCard.fromProductModel(model: model);
    }, provider: productProvider);
  }
}
