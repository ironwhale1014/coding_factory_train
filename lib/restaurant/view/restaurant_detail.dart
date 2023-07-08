import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/product/component/product_card.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:flutter/material.dart';

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "불타는 떡볶이",
      child: CustomScrollView(
        slivers: [
          renderTop(), renderMenu(),
          renderProducts()
        ],
      )

      // Column(
      //   children: [
      ,
      //     Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
      //       child: const ProductCard(),
      //     )
      //   ],
      // ),
    );
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

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(delegate: SliverChildBuilderDelegate((context, index) {
        return const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: ProductCard(),
        );
      })),
    );
  }

  SliverToBoxAdapter renderTop() {
    return SliverToBoxAdapter(
      child: RestaurantCard(
        image: Image.asset("asset/img/food/ddeok_bok_gi.jpg"),
        name: "불타는 떡볶이",
        tags: ["떡볶이", "맛있음", "치즈"],
        ratingsCount: 100,
        deliveryTime: 30,
        deliveryFee: 3000,
        ratings: 4.7,
        isDetail: true,
        detail: "맛있는 떡볶이",
      ),
    );
  }
}
