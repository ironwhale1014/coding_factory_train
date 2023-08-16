import 'package:json_annotation/json_annotation.dart';

part 'cursorpagination_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationLoading extends CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({required this.message});
}

/*
 "meta": {
        "count": 20,
        "hasMore": true
    },
 */
@JsonSerializable()
class Meta {
  final int count;
  final bool hasMore;

  Meta({required this.count, required this.hasMore});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> extends CursorPaginationBase {
  final Meta meta;
  final List<T> data;

  CursorPagination({required this.meta, required this.data});

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);

  CursorPagination copyWith({Meta? meta, List<T>? data}) {
    return CursorPagination<T>(
        meta: meta ?? this.meta, data: data ?? this.data);
  }
}

class CursorPaginationFetchMore<T> extends CursorPagination<T> {
  CursorPaginationFetchMore({required super.meta, required super.data});
}

class CursorPaginationRefetch<T> extends CursorPagination<T> {
  CursorPaginationRefetch({required super.meta, required super.data});
}
