import 'package:coding_factory_train/restaurant/component/restaurant_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
  }
}
