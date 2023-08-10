import 'package:coding_factory_train/common/model/model_with_id.dart';
import 'package:coding_factory_train/common/util/data_util.dart';
import 'package:coding_factory_train/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  @override
  final String id;
  final String name;
  final String detail;
  @JsonKey(fromJson: DataUtils.pathToURL)
  final String imgUrl;
  final int price;
  final RestaurantModel restaurant;

  ProductModel(
      {required this.id,
      required this.name,
      required this.detail,
      required this.imgUrl,
      required this.price,
      required this.restaurant});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
