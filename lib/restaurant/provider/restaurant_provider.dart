import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider =
    StateNotifierProvider<RestaurantNotifier, List<RestaurantModel>>((ref) {
  return RestaurantNotifier(
      repository: ref.watch(restaurantRepositoryProvider));
});

class RestaurantNotifier extends StateNotifier<List<RestaurantModel>> {
  final RestaurantRepository repository;

  RestaurantNotifier({required this.repository}) : super([]);

  Future<void> paginate() async {
    final cursorPagination = await repository.paginate();
    state = cursorPagination.data;
  }
}
