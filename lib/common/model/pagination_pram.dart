import 'package:json_annotation/json_annotation.dart';

part 'pagination_pram.g.dart';

@JsonSerializable()
class PaginationParam {
  final int? count;
  final String? after;

  const PaginationParam({ this.count,this.after,});

  factory PaginationParam.fromJson(Map<String, dynamic> json) =>
      _$PaginationParamFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParamToJson(this);

  PaginationParam copyWith({String? after, int? count}) {
    return PaginationParam(
        after: after ?? this.after, count: count ?? this.count);
  }
}
