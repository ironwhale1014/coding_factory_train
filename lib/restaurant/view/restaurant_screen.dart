import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/model/cursorpagination_model.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

    final cp = restaurantState as CursorPagination;

    return const Center(
      child: Text("home1"),
    );
  }
}
