import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> {
  final Meta meta;
  final List<T> data;

  CursorPagination({required this.meta, required this.data});

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJson) =>
      _$CursorPaginationFromJson(json, fromJson);
}

@JsonSerializable()
class Meta {
  final int count;
  final bool hasMore;

  Meta({required this.count, required this.hasMore});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}
