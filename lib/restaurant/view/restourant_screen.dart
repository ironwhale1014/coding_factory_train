import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    final dio = Dio();
    final accessToken = await storage.read(key: ACCESS_TOKEN);

    final resp = await dio.get("$ip/restaurant",
        options: Options(headers: {"authorization": 'Bearer $accessToken'}));
    print(resp.data["data"]);
    return resp.data["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: FutureBuilder<List>(
          future: paginateRestaurant(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return ListView.separated(
                itemBuilder: (_, index) {
                  final item = snapshot.data![index];
                  final pItem = RestaurantModel.fromJson(item);
                  return RestaurantCard.fromModel(
                    pItem: pItem,
                  );
                },
                separatorBuilder: (_, index) => SizedBox(height: 10),
                itemCount: snapshot.data!.length);
          }),
    ));
  }
}
