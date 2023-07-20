import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_cart.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<RestaurantModel> data = ref.watch(restaurantProvider);

    if (data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
        itemBuilder: (context, index) {
          return RestaurantCard(
            image: Image.asset("asset/img/food/ddeok_bok_gi.jpg"),
            name: '불타는 떡볶이',
            tags: const ["떡볶이", "치즈", "매운맛"],
            priceRange: 'cheap',
            ratings: 4.89,
            ratingsCount: 200,
            deliveryTime: 20,
            deliveryFee: 2000,
          );
        },
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemCount: data.length);
  }
}
