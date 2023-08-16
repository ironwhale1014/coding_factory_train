import 'package:coding_factory_train/common/const/utils.dart';
import 'package:coding_factory_train/common/model/id_with_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

/*
{
    "meta": {
        "count": 20,
        "hasMore": true
    },
    "data": [
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
        },
 ]
 */

enum PriceRange { medium, cheap, expensive }

@JsonSerializable()
class RestaurantModel implements IModelWithId {
  @override
  final String id;
  final String name;
  @JsonKey(fromJson: UrlUtils.stringToUrl)
  final String thumbUrl;
  final List<String> tags;
  final PriceRange priceRange;
  final double ratings;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel(
      {required this.name,
      required this.thumbUrl,
      required this.tags,
      required this.priceRange,
      required this.ratings,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.id});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
}
