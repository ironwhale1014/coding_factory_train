import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/const/utils.dart';
import 'package:coding_factory_train/common/model/cursorpagination_model.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:coding_factory_train/restaurant/view/restaurnat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
        controller: controller,
        provider: ref.read(restaurantProvider.notifier));
  }

  @override
  Widget build(BuildContext context) {
    final restaurantState = ref.watch(restaurantProvider);

    if (restaurantState is CursorPaginationLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: PRIMARY_COLOR,
      ));
    }

    if (restaurantState is CursorPaginationError) {
      logger.e(restaurantState.message);
    }

    final cp = restaurantState as CursorPagination<RestaurantModel>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length + 1,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 16);
        },
        itemBuilder: (context, index) {
          if (cp.data.length == index) {
            return Center(
              child: (restaurantState is CursorPaginationFetchMore)
                  ? const CircularProgressIndicator()
                  : const Text("no more data"),
            );
          }

          final RestaurantModel restaurantModel = cp.data[index];
          return InkWell(
              onTap: () {
                logger.d("click");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => RestaurantDetailScreen(
                        name: restaurantModel.name, id: restaurantModel.id)));
              },
              child: RestaurantCard.fromModel(model: restaurantModel));
        },
      ),
    );
  }
}
