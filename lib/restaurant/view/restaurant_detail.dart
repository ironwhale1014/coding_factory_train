import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/product/component/product_card.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail({super.key, required this.id});

  final String id;

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN);
    final response = await dio.get("$ip/restaurant/$id",
        options: Options(headers: {"authorization": 'Bearer $accessToken'}));
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: "불타는 떡볶이",
        child: FutureBuilder<Map<String, dynamic>>(
          future: getRestaurantDetail(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final item = RestaurantDetailModel.fromJson(snapshot.data!);

            return CustomScrollView(
              slivers: [renderTop(model: item), renderMenu(), renderProducts()],
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

  SliverPadding renderProducts() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate:
              SliverChildBuilderDelegate(childCount: 10, (context, index) {
        return const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: ProductCard(),
        );
      })),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(pItem: model,isDetail: true),
    );
  }
}
