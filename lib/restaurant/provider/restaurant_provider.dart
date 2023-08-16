import 'package:coding_factory_train/common/model/cursorpagination_model.dart';
import 'package:coding_factory_train/common/provider/paginate_provider.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider = StateNotifierProvider<
    RestaurantProvider,
    CursorPaginationBase>(
        (ref) {
          final repo = ref.watch(restaurantRepositoryProvider);
      return RestaurantProvider(repository:repo);
    }
);

class RestaurantProvider
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantProvider({ required super.repository});
}
