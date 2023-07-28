import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_cart.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantDetailScreen extends ConsumerWidget {
  final String id;
  final String name;

  const RestaurantDetailScreen(
      {super.key, required this.id, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
        title: name,
        child: FutureBuilder<RestaurantDetailModel>(
          future: ref
              .watch(restaurantRepositoryProvider)
              .getRestaurantDetail(id: id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              logger.d(snapshot.error);
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final item = snapshot.data!;

            return CustomScrollView(slivers: [renderTop(model: item)]);
          },
        ));
  }

  SliverToBoxAdapter renderTop({required RestaurantModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(restaurantModel: model, isDetail: true),
    );
  }
}
