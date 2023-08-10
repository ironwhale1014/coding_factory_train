import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_cart.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:coding_factory_train/restaurant/view/restaurant_detail_screen.dart';
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
    PaginationUtils.paginate(
        controller: controller,
        provider: ref.read(restaurantProvider.notifier));
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        controller: controller,
        itemBuilder: (context, index) {
          if (index == ps.data.length) {
            return Center(
                child: state is CursorPaginationFetchMore
                    ? const CircularProgressIndicator()
                    : const Text("Last Data"));
          }

          final RestaurantModel pItem = ps.data[index];

          return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RestaurantDetailScreen(
                          id: pItem.id,
                          name: pItem.name,
                        )));
              },
              child: RestaurantCard.fromModel(restaurantModel: pItem));
        },
        separatorBuilder: (_, index) => const SizedBox(height: 8),
        itemCount: ps.data.length + 1);
  }
}
