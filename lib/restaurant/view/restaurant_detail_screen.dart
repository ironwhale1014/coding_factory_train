import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/products/product_card.dart';
import 'package:coding_factory_train/products/product_model.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_cart.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;
  final String name;

  const RestaurantDetailScreen(
      {super.key, required this.id, required this.name});

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(gRestaurantDetailProvider(id: widget.id));

    if (item == null) {
      return DefaultLayout(
          child: const Center(
        child: CircularProgressIndicator(),
      ));
    }

    return DefaultLayout(
        title: widget.name,
        child: CustomScrollView(slivers: [
          renderTop(model: item),
          if (item is! RestaurantDetailModel) renderLoading(),
          if (item is RestaurantDetailModel) renderMenu(),
          if (item is RestaurantDetailModel)
            renderProducts(products: item.products)
        ]));
  }
  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                    style: SkeletonParagraphStyle(lines: 5,padding: EdgeInsets.zero),
                  ),
            ))),
      ),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(restaurantModel: model, isDetail: true),
    );
  }

  SliverPadding renderMenu() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          "Menu",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  renderProducts({required List<ProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(childCount: products.length,
              (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ProductCard.fromModel(products[index]),
        );
      })),
    );
  }
}
