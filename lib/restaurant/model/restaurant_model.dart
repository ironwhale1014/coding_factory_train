import 'package:coding_factory_train/common/const/data.dart';

enum RestaurantPriceRange { medium, cheap, expensive }

class RestaurantModel {
  final String id;
  final String name;
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;
  final double ratings;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
        id: json["id"],
        name: json["name"],
        thumbUrl: '$ip${json["thumbUrl"]}',
        tags: List<String>.from(json["tags"]),
        priceRange: RestaurantPriceRange.values
            .firstWhere((e) => e.name == json["priceRange"]),
        ratingsCount: json["ratingsCount"],
        deliveryTime: json["deliveryTime"],
        deliveryFee: json["deliveryFee"],
        ratings: json["ratings"]);
  }
}
