import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({required this.message});
}

// 로딩할때
class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> extends CursorPaginationBase {
  final Meta meta;
  final List<T> data;

  CursorPagination({required this.meta, required this.data});

  CursorPagination copyWith({Meta? meta, List<T>? data}) {
    return CursorPagination(meta: meta ?? this.meta, data: data ?? this.data);
  }

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJson) =>
      _$CursorPaginationFromJson(json, fromJson);
}

@JsonSerializable()
class Meta {
  final int count;
  final bool hasMore;

  Meta({required this.count, required this.hasMore});

  Meta copyWith({int? count, bool? hasMore}) {
    return Meta(count: count ?? this.count, hasMore: hasMore ?? this.hasMore);
  }
  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

// 데이터 있는데 새로고침 할때
class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({required super.meta, required super.data});
}

// 데이터 있는데 맨 아래 갔을 때 새로운 값 가지고 올때
class CursorPaginationfetchingMore<T> extends CursorPagination<T> {
  CursorPaginationfetchingMore({required super.meta, required super.data});

}
