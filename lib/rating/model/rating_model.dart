/*
{
  "meta": {
    "count": 20,
    "hasMore": true
  },
  "data": [
    {
      "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
      "user": {
        "id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
        "username": "test@codefactory.ai",
        "imageUrl": "/img/logo.png"
      },
      "rating": 5,
      "content": "너무 맛있어요~",
      "imgUrls": [
        "/img/test.png"
      ]
    }
  ]
}
 */
import 'package:coding_factory_train/common/model/model_with_id.dart';
import 'package:coding_factory_train/common/util/data_util.dart';
import 'package:coding_factory_train/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId{
  @override
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  @JsonKey(fromJson: DataUtils.pathToULRs)
  final List<String> imgUrls;

  RatingModel(
      {required this.id,
      required this.user,
      required this.rating,
      required this.content,
      required this.imgUrls});
  
  factory RatingModel.fromJson(Map<String, dynamic> json)
  =>_$RatingModelFromJson(json);
}
