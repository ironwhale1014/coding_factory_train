import 'package:coding_factory_train/common/const/util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

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

@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  @JsonKey(fromJson: DataUtil.stringToUrl)
  final String imgUrl;
  final String detail;
  final int price;

  ProductModel(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.detail,
      required this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
