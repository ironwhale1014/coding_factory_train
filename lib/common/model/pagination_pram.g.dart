// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_pram.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParam _$PaginationParamFromJson(Map<String, dynamic> json) =>
    PaginationParam(
      count: json['count'] as int?,
      after: json['after'] as String?,
    );

Map<String, dynamic> _$PaginationParamToJson(PaginationParam instance) =>
    <String, dynamic>{
      'count': instance.count,
      'after': instance.after,
    };
