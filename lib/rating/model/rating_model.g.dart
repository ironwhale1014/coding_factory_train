// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingModel _$RatingModelFromJson(Map<String, dynamic> json) => RatingModel(
      id: json['id'] as String,
      imgUrls: DataUtil.listToUrl(json['imgUrls'] as List),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String,
      rating: json['rating'] as int,
    );

Map<String, dynamic> _$RatingModelToJson(RatingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imgUrls': instance.imgUrls,
      'user': instance.user,
      'content': instance.content,
      'rating': instance.rating,
    };
