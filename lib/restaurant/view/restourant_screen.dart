import 'package:coding_factory_train/common/component/pagination_list_view.dart';
import 'package:coding_factory_train/common/util/pagination_utils.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:coding_factory_train/restaurant/view/restaurant_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/model/cursor_pagination_model.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
        provider: restaurantProvider,
        itemBuilder: <RestaurantModel>(context, index, model) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => RestaurantDetail(id: model.id)));
            },
            child: RestaurantCard.fromModel(
              pItem: model,
            ),
          );
        });
  }
}
