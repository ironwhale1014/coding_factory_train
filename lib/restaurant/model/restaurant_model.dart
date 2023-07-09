import 'package:coding_factory_train/common/const/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange { medium, cheap, expensive }

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(fromJson: pathToURL)
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
    return _$RestaurantModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  static pathToURL(String value) {
    return '$ip$value';
  }

// factory RestaurantModel.fromJson(Map<String, dynamic> json) {
//   return RestaurantModel(
//       id: json["id"],
//       name: json["name"],
//       thumbUrl: '$ip${json["thumbUrl"]}',
//       tags: List<String>.from(json["tags"]),
//       priceRange: RestaurantPriceRange.values
//           .firstWhere((e) => e.name == json["priceRange"]),
//       ratingsCount: json["ratingsCount"],
//       deliveryTime: json["deliveryTime"],
//       deliveryFee: json["deliveryFee"],
//       ratings: json["ratings"]);
// }
}
