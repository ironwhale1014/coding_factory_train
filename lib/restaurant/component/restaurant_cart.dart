import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final String priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final bool isDetail;
  final String? detail;
  final String? heroKey;

  const RestaurantCard(
      {super.key,
      required this.name,
      required this.image,
      required this.tags,
      required this.priceRange,
      required this.ratings,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee,
      this.isDetail = false,
      this.detail,
      this.heroKey});

  factory RestaurantCard.fromModel(
      {required RestaurantModel restaurantModel, bool isDetail = false}) {
    return RestaurantCard(
      image: Image.network(restaurantModel.thumbUrl, fit: BoxFit.cover),
      name: restaurantModel.name,
      tags: restaurantModel.tags,
      priceRange: restaurantModel.priceRange.toString(),
      ratings: restaurantModel.ratings,
      ratingsCount: restaurantModel.ratingsCount,
      deliveryTime: restaurantModel.deliveryTime,
      deliveryFee: restaurantModel.deliveryFee,
      isDetail: isDetail,
      detail: restaurantModel is RestaurantDetailModel
          ? restaurantModel.detail
          : null,
      heroKey: restaurantModel.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (heroKey != null)
          Hero(
            tag: ObjectKey(heroKey),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(isDetail ? 0 : 16),
                child: image),
          ),
        if (heroKey ==null)
          ClipRRect(
              borderRadius: BorderRadius.circular(isDetail ? 0 : 16),
              child: image),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              const SizedBox(height: 8),
              Text(tags.join("·")),
              const SizedBox(height: 8),
              Row(
                children: [
                  _iconText(icon: Icons.star, label: ratings.toString()),
                  _renderDot(),
                  _iconText(
                      icon: Icons.receipt, label: ratingsCount.toString()),
                  _renderDot(),
                  _iconText(
                      icon: Icons.timelapse_outlined,
                      label: "${deliveryTime.toString()} min"),
                  _renderDot(),
                  _iconText(
                      icon: Icons.monetization_on,
                      label:
                          (deliveryFee == 0) ? "무료" : deliveryFee.toString()),
                ],
              ),
              if (detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(detail!),
                )
            ],
          ),
        ),
      ],
    );
  }
}

Widget _renderDot() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Text(
      "·",
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
    ),
  );
}

class _iconText extends StatelessWidget {
  _iconText({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14,
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        )
      ],
    );
  }
}
