import 'package:coding_factory_train/common/util/data_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

/// id : "1952a209-7c26-4f50-bc65-086f6e64dbbd"
/// name : "우라나라에서 가장 맛있는 짜장면집"
/// thumbUrl : "/img/thumb.png"
/// tags : ["신규","세일중"]
/// priceRange : "cheap"
/// ratings : 4.89
/// ratingsCount : 200
/// deliveryTime : 20
/// deliveryFee : 3000

enum PriceRange { medium, cheap, expensive }

@JsonSerializable()
class RestaurantModel {
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtil.stringToUrl)
  final String thumbUrl;
  final List<String> tags;
  final PriceRange priceRange;
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

