// {
// "meta": {
// "count": 20,
// "hasMore": true
// },
// "data": [
// {
// "id": "5ac83bfb-f2b5-55f4-be3c-564be3f01a5b",
// "name": "불타는 떡볶이",
// "thumbUrl": "/img/떡볶이/떡볶이.jpg",
// "tags": [
// "떡볶이",
// "치즈",
// "매운맛"
// ],
// "priceRange": "medium",
// "ratings": 4.52,
// "ratingsCount": 100,
// "deliveryTime": 15,
// "deliveryFee": 2000
// },

import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationLoading extends CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({required this.message});
}

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> extends CursorPaginationBase {
  final Meta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);

  CursorPagination copyWith({Meta? meta, List<T>? data}) {
    return CursorPagination(meta: meta ?? this.meta, data: data ?? this.data);
  }
}

class CursorPaginationRefetch<T> extends CursorPagination<T> {
  CursorPaginationRefetch({required super.meta, required super.data});
}

class CursorPaginationFetchMore<T> extends CursorPagination<T> {
  CursorPaginationFetchMore({required super.meta, required super.data});
}

@JsonSerializable()
class Meta {
  final int count;
  final bool hasMore;

  Meta({required this.count, required this.hasMore});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}
