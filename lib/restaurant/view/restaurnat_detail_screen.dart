import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/common/layout/default_layout.dart';
import 'package:coding_factory_train/restaurant/component/product_card.dart';
import 'package:coding_factory_train/restaurant/component/restaurant_card.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:coding_factory_train/restaurant/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  const RestaurantDetailScreen(
      {required this.id, required this.name, super.key});

  final String id;
  final String name;

  @override
  ConsumerState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(restaurantProvider.notifier).getDetail(id: widget.id);
    controller.addListener(listener);
  }

  void listener() {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(restaurantDetailProvider(widget.id));

    logger.d(model);

    if (model == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return DefaultLayout(
        title: widget.name,
        child: CustomScrollView(
          controller: controller,
          slivers: [
            _renderTop(model),
            if (model is! RestaurantDetailModel) _renderLoading(),
            _renderMenu(),
            if(model is RestaurantDetailModel)
            _renderProducts(model: model.products)
          ],
        ));
  }

  SliverPadding _renderProducts({required List<ProductModel> model}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(childCount: model.length,
            (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ProductCard.fromModel(model: model[index]),
          );
        }),
      ),
    );
  }

  SliverPadding _renderMenu() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      sliver: SliverToBoxAdapter(
        child: Text("Menu",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
      ),
    );
  }

  SliverPadding _renderLoading() {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildListDelegate(List.generate(
            3,
            (index) => SkeletonParagraph(
                  style: const SkeletonParagraphStyle(
                      lines: 5, padding: EdgeInsets.zero),
                ))),
      ),
    );
  }

  SliverToBoxAdapter _renderTop(RestaurantModel model) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }
}
