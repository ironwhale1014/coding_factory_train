import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/util/pagination_utils.dart';
import 'package:coding_factory_train/product/component/product_card.dart';
import 'package:coding_factory_train/rating/component/rating_cart.dart';
import 'package:coding_factory_train/rating/model/rating_model.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_rating_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetail extends ConsumerStatefulWidget {
  const RestaurantDetail({super.key, required this.id});

  final String id;

  @override
  ConsumerState<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends ConsumerState<RestaurantDetail> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    controller.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
        controller: controller,
        provider: ref.read(restaurantRatingProvider(widget.id).notifier));
  }

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(gRestaurantDetailProvider(id: widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));

    print(ratingsState);

    if (item == null) {
      return DefaultLayout(
        title: "불타는 떡볶이",
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return DefaultLayout(
      title: "불타는 떡볶이",
      child: CustomScrollView(
        controller: controller,
        slivers: [
          renderTop(model: item),
          if (item is! RestaurantDetailModel) renderLoading(),
          if (item is RestaurantDetailModel) renderMenu(),
          if (item is RestaurantDetailModel)
            renderProducts(products: item.products),
          if (ratingsState is CursorPagination<RatingModel>)
            renderRatings(models: ratingsState.data)
        ],
      ),
    );
  }

  SliverPadding renderRatings({required List<RatingModel> models}) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RatingCard.fromModel(ratingModel: models[index]),
                ),
            childCount: models.length),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(List.generate(
            3,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: SkeletonParagraph(
                    style: const SkeletonParagraphStyle(
                        lines: 5, padding: EdgeInsets.zero),
                  ),
                ))),
      ),
    );
  }

  SliverPadding renderMenu() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text(
          "Menu",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
    );
  }

  SliverPadding renderProducts(
      {required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(childCount: products.length,
              (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: ProductCard.fromRestaurantProductModel(model: products[index]),
        );
      })),
    );
  }

  SliverToBoxAdapter renderTop({required RestaurantModel model}) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(pItem: model, isDetail: true),
    );
  }
}
