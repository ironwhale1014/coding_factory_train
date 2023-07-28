/*
"products": [
    {
      "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
      "name": "마라맛 코팩 떡볶이",
      "imgUrl": "/img/img.png",
      "detail": "서울에서 두번째로 맛있는 떡볶이집! 리뷰 이벤트 진행중~",
      "price": 8000
    }
  ]
 */

import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/products/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final Widget image;
  final String detail;
  final int price;

  ProductCard(
      {required this.name,
      required this.image,
      required this.detail,
      required this.price});

  factory ProductCard.fromModel(ProductModel productModel) {
    return ProductCard(
      name: productModel.name,
      image: Image.network(
        productModel.imgUrl,
        fit: BoxFit.cover,
        width: 110,
        height: 110,
      ),
      detail: productModel.detail,
      price: productModel.price,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(8), child: image),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(detail,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: BODY_TEXT_COLOR)),
                Text("₩$price",
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: PRIMARY_COLOR)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
