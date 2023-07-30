import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/products/product_model.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_detail_model.g.dart';

/*

{
  "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
  "name": "우라나라에서 가장 맛있는 짜장면집",
  "thumbUrl": "/img/thumb.png",
  "tags": [
    "신규",
    "세일중"
  ],
  "priceRange": "cheap",
  "ratings": 4.89,
  "ratingsCount": 200,
  "deliveryTime": 20,
  "deliveryFee": 3000,
  "detail": "오늘 주문하면 배송비 3000원 할인!",
  "products": [
    {
      "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
      "name": "마라맛 코팩 떡볶이",
      "imgUrl": "/img/img.png",
      "detail": "서울에서 두번째로 맛있는 떡볶이집! 리뷰 이벤트 진행중~",
      "price": 8000
    }
  ]
}

 */

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<ProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });




  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json)
  => _$RestaurantDetailModelFromJson(json);
}
