import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../user/model/user_model.dart';

part 'rating_model.g.dart';

/*
        {
            "id": "9eca580a-d614-44fd-a8a9-1f1e8176c3d8",
            "imgUrls": [],
            "user": {
                "id": "f55b32d2-4d68-4c1e-a3ca-da9d7d0d92e5",
                "username": "test@codefactory.ai",
                "imageUrl": "/img//logo/codefactory_logo.png"
            },
            "content": "양도 많고 맛있어요~ 배달기사님도 이때까지 뵀던 분중에 가장 친절하셨습니다 ㅎㅎ",
            "rating": 5
        }
 */

@JsonSerializable()
class RatingModel implements IModelWithId {
  @override
  final String id;
  @JsonKey(fromJson: DataUtil.listToUrl)
  final List<String> imgUrls;
  final UserModel user;
  final String content;
  final int rating;

  RatingModel(
      {required this.id,
      required this.imgUrls,
      required this.user,
      required this.content,
      required this.rating});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
