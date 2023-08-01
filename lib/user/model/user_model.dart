/*
"user": {
"id": "1952a209-7c26-4f50-bc65-086f6e64dbbd",
"username": "test@codefactory.ai",
"imageUrl": "/img/logo.png"
},
 */

import 'package:coding_factory_train/common/util/data_util.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  @JsonKey(fromJson: DataUtils.pathToURL)
  final String imageUrl;

  UserModel({required this.id, required this.username, required this.imageUrl});
  
  factory UserModel.fromJson(Map<String, dynamic> json)
  =>_$UserModelFromJson(json);
}
