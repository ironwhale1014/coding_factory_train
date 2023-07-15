import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/product/component/product_card.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetail extends ConsumerWidget {
  const RestaurantDetail({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        title: "불타는 떡볶이",
        child: FutureBuilder<RestaurantDetailModel>(
          future: ref
              .watch(restaurantRepositoryProvider)
              .getRestaurantDetail(id: id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final item = snapshot.data!;

            return CustomScrollView(
              slivers: [
                renderTop(model: item),
                renderMenu(),
                renderProducts(products: item.products)
              ],
            );
          },
        ));
  }

  SliverPadding renderMenu() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          "Menu",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(childCount: products.length,
              (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: ProductCard.fromModel(model: products[index]),
        );
      })),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(pItem: model, isDetail: true),
    );
  }
}
