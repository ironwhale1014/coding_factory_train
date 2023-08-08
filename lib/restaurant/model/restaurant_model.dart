import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

// """
// {
// "id": "5ac83bfb-f2b5-55f4-be3c-564be3f01a5b",
// "name": "불타는 떡볶이",
// "thumbUrl": "/img/떡볶이/떡볶이.jpg",
// "tags": [
// "떡볶이",
// "치즈",
// "매운맛"
// ],
// "priceRange": "medium",
// "ratings": 4.52,
// "ratingsCount": 100,
// "deliveryTime": 15,
// "deliveryFee": 2000
// }
// """

enum RestaurantPriceRange { medium, cheap, expensive }

@JsonSerializable()
class RestaurantModel implements IModelWithId {
  @override
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtil.stringToUrl)
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel(
      {required this.id,
      required this.name,
      required this.thumbUrl,
      required this.tags,
      required this.priceRange,
      required this.ratings,
      required this.ratingsCount,
      required this.deliveryTime,
      required this.deliveryFee});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
}
