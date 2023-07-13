import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/dio/dio.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/repository/restaurant_repository.dart';
import 'package:coding_factory_train/restaurant/view/restaurant_detail.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(CustomInterceptor(storage: storage));

    final repository = RestaurantRepository(dio, baseUrl: "$ip/restaurant");
    final resp = await repository.paginate();
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder<List<RestaurantModel>>(
          future: paginateRestaurant(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.separated(
                itemBuilder: (_, index) {
                  final pItem = snapshot.data![index];
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
                itemCount: snapshot.data!.length);
          }),
    ));
  }
}
