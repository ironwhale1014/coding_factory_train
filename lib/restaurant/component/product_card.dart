import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_detail_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.name,
      required this.image,
      required this.detail,
      required this.price});

  final String name;
  final Widget image;
  final String detail;
  final int price;

  factory ProductCard.fromModel({required ProductModel model}) {
    return ProductCard(
        name: model.name,
        image: Image.network(
          model.imgUrl,
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        detail: model.detail,
        price: model.price);
  }

  @override
  Widget build(BuildContext context) {
    logger.d("hou");
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(16), child: image),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18)),
                Text(
                  detail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "₩ $price",
                  style: const TextStyle(color: PRIMARY_COLOR),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
