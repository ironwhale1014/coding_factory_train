import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:coding_factory_train/restaurant/view/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination_model.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant(WidgetRef ref) async {
    final repository = ref.watch(restaurantRepositoryProvider);
    final resp = await repository.paginate();
    return resp.data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
      itemBuilder: (_, index) {
        final pItem = data[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => RestaurantDetail(id: pItem.id)));
          },
          child: RestaurantCard.fromModel(
            pItem: pItem,
          ),
        );
      },
      separatorBuilder: (_, index) => const SizedBox(height: 10),
      itemCount: data.length),
    );
  }
}
