// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imgUrl: UrlUtils.stringToUrl(json['imgUrl'] as String),
      detail: json['detail'] as String,
      price: json['price'] as int,
    );

Map<String, dynamic> _$ProductToJson(ProductModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'detail': instance.detail,
      'price': instance.price,
    };

RestaurantDetailModel _$RestaurantDetailModelFromJson(
        Map<String, dynamic> json) =>
    RestaurantDetailModel(
      detail: json['detail'] as String,
      products: (json['products'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      thumbUrl: UrlUtils.stringToUrl(json['thumbUrl'] as String),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      priceRange: $enumDecode(_$PriceRangeEnumMap, json['priceRange']),
      ratings: (json['ratings'] as num).toDouble(),
      deliveryTime: json['deliveryTime'] as int,
      deliveryFee: json['deliveryFee'] as int,
      ratingsCount: json['ratingsCount'] as int,
      id: json['id'] as String,
    );

Map<String, dynamic> _$RestaurantDetailModelToJson(
        RestaurantDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbUrl': instance.thumbUrl,
      'tags': instance.tags,
      'priceRange': _$PriceRangeEnumMap[instance.priceRange]!,
      'ratingsCount': instance.ratingsCount,
      'ratings': instance.ratings,
      'deliveryTime': instance.deliveryTime,
      'deliveryFee': instance.deliveryFee,
      'detail': instance.detail,
      'products': instance.products,
    };

const _$PriceRangeEnumMap = {
  PriceRange.medium: 'medium',
  PriceRange.cheap: 'cheap',
  PriceRange.expensive: 'expensive',
};
