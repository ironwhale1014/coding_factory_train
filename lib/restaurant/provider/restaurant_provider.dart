import 'package:coding_factory_train/common/util/logger.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_provider.g.dart';

@riverpod
class Restaurant extends _$Restaurant {
  late final RestaurantRepository restaurantRepository;

  Restaurant() {
    logger.d("생성자");
    paginate();
  }

  @override
  List<RestaurantModel> build() {
    logger.d("빌드");
    restaurantRepository = ref.read(restaurantRepositoryProvider);
    return [];
  }

  Future<void> paginate() async {
    final cursorPagination = await restaurantRepository.paginate();

    state = cursorPagination.data;
  }
}
