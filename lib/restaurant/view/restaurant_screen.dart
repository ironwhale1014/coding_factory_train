import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_cart.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final CursorPaginationBase state = ref.watch(restaurantProvider);

    if (state is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CursorPaginationError) {
      return Center(child: Text(state.message));
    }

    final ps = state as CursorPagination;


    return ListView.separated(
        itemBuilder: (context, index) {
          final pItem = ps.data[index];

          return InkWell(
              onTap: () {
                logger.d("push tap");
              },
              child: RestaurantCard.fromModel(restaurantModel: pItem));
        },
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemCount: ps.data.length);
  }
}
