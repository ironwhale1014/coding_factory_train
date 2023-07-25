import 'package:json_annotation/json_annotation.dart';

part 'pagination_param.g.dart';

@JsonSerializable()
class PaginationParam {
  final String? after;
  final int? count;

  // const 필수
  const PaginationParam({this.after, this.count});

  PaginationParam copyWith({String? after, int? count}) {
    return PaginationParam(
        after: after ?? this.after, count: count ?? this.count);
  }

  factory PaginationParam.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamToJson(this);
}
