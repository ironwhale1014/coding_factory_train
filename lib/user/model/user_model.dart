/*
          "user": {
                "id": "f55b32d2-4d68-4c1e-a3ca-da9d7d0d92e5",
                "username": "test@codefactory.ai",
                "imageUrl": "/img//logo/codefactory_logo.png"
            },
 */

import 'package:coding_factory_train/common/const/util.dart';
import 'package:coding_factory_train/common/model/model_with_id.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel implements IModelWithId {
  @override
  final String id;
  final String username;
  @JsonKey(fromJson: DataUtil.stringToUrl)
  final String imageUrl;

  UserModel({required this.id, required this.username, required this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
