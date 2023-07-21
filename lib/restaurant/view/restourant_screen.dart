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

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  // 이것을 사용하지 위해 ConsumerStatefulWidget 변경
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(scrollListener);
  }

  void scrollListener() {
    // 현재 위치가 최대 길이보다 조금 덜되는 위치에 오면 데이터를 추가 요청
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    //완전 처음 로딩할때
    if (data is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    //에러 날때
    if (data is CursorPaginationError) {
      return Center(child: Text(data.message));
    }

    //CusorPagination
    //CursorPaginationfetchingMore
    // CursorPaginationRefetching
    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
          controller: controller,
          itemBuilder: (_, index) {
            if (index == cp.data.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                child: Center(
                    child: data is CursorPaginationfetchingMore
                        ? const CircularProgressIndicator()
                        : const Text("마지막 데이터 입니다.")),
              );
            }

            final pItem = cp.data[index];
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
          itemCount: cp.data.length + 1),
    );
  }
}
