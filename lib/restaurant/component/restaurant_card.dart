import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:flutter/material.dart';

import '../../common/const/data.dart';

/*
{
  "id": "5ac83bfb-f2b5-55f4-be3c-564be3f01a5b",
  "name": "불타는 떡볶이",
  "thumbUrl": "/img/떡볶이/떡볶이.jpg",
  "tags": [
    "떡볶이",
    "치즈",
    "매운맛"
  ],
  "priceRange": "medium",
  "ratings": 4.52,
  "ratingsCount": 100,
  "deliveryTime": 15,
  "deliveryFee": 2000
}
 */

class RestaurantCard extends StatelessWidget {
  const RestaurantCard(
      {super.key,
      this.isDetail = false,
      this.detail,
      required this.name,
      required this.image,
      required this.tags,
      required this.ratings,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee});

  final String name;
  final Widget image;
  final List<String> tags;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final bool isDetail;
  final String? detail;

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      name: model.name,
      image: Image.network(model.thumbUrl, fit: BoxFit.cover),
      tags: model.tags,
      ratings: model.ratings,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      isDetail: isDetail,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDetail) image,
        if (!isDetail)
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: image,
          ),
        const SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 20)),
              const SizedBox(height: 8),
              Text(
                tags.join(" · "),
                style: const TextStyle(fontSize: 14, color: BODY_TEXT_COLOR),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _IconText(label: ratings.toString(), icon: Icons.star),
                  _renderDot(),
                  _IconText(
                      label: ratingsCount.toString(), icon: Icons.receipt),
                  _renderDot(),
                  _IconText(
                      label: "$deliveryTime min",
                      icon: Icons.timelapse_outlined),
                  _renderDot(),
                  _IconText(
                      label: deliveryFee == 0 ? "무료" : deliveryFee.toString(),
                      icon: Icons.monetization_on),
                ],
              ),
              const SizedBox(height: 8),
              if (isDetail && detail != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(detail!),
                )
            ],
          ),
        )
      ],
    );
  }

  Widget _renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
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
