import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String name;
  final List<String> tags;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;
  final bool isDetail;

  final String? detail;

  RestaurantCard(
      {super.key,
      required this.image,
      required this.name,
      required this.tags,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.ratings,
      this.isDetail = false,
      this.detail});

  factory RestaurantCard.fromModel(
      {required RestaurantModel pItem, bool isDetail = false}) {
    return RestaurantCard(
      image: Image.network(pItem.thumbUrl, fit: BoxFit.cover),
      name: pItem.name,
      tags: pItem.tags,
      ratingsCount: pItem.ratingsCount,
      deliveryTime: pItem.deliveryTime,
      deliveryFee: pItem.deliveryFee,
      ratings: pItem.ratings,
      isDetail: isDetail,
      detail: pItem is RestaurantDetailModel ? pItem.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDetail) image,
        if (!isDetail)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image,
          ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text(
                tags.join(" · "),
                style: const TextStyle(fontSize: 14, color: BODY_TEXT_COLOR),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _IconText(label: ratings.toString(), icon: Icons.star),
                  renderDot(),
                  _IconText(
                      label: ratingsCount.toString(), icon: Icons.receipt),
                  renderDot(),
                  _IconText(
                      label: "$deliveryTime min",
                      icon: Icons.timelapse_outlined),
                  renderDot(),
                  _IconText(
                      label: deliveryFee == 0 ? '무료' : deliveryFee.toString(),
                      icon: Icons.monetization_on),
                ],
              ),
              if (isDetail && detail != null)
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(detail!))
            ],
          ),
        )
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        "·",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  const _IconText({super.key, required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        )
      ],
    );
  }
}
