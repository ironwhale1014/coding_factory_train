import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
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
          final pItem = data[index];
          return RestaurantCard.fromModel(pItem: pItem);
        },
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemCount: data.length);
  }
}
