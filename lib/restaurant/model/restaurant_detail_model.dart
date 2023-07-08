import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> product;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required super.ratings,
    required this.detail,
    required this.product,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailModel(
        id: json["id"],
        name: json["name"],
        thumbUrl: '$ip${json["thumbUrl"]}',
        tags: List<String>.from(json["tags"]),
        priceRange: RestaurantPriceRange.values.firstWhere(
            (RestaurantPriceRange e) => e.name == json["priceRange"]),
        ratingsCount: json["ratingsCount"],
        deliveryTime: json["deliveryTime"],
        deliveryFee: json["deliveryFee"],
        ratings: json["ratings"],
        detail: json["detail"],
        product: json["products"].map<RestaurantProductModel>((x) =>
           RestaurantProductModel(
            id: x["id"],
            name: x["name"],
            imgUrl: x["imgUrl"],
            detail: x["detail"],
            price: x["price"],
          )
        ).toList());
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });
}
