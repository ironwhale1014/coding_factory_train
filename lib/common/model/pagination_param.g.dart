// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParam _$PaginationParamFromJson(Map<String, dynamic> json) =>
    PaginationParam(
      after: json['after'] as String?,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$PaginationParamToJson(PaginationParam instance) =>
    <String, dynamic>{
      'after': instance.after,
      'count': instance.count,
    };
