import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_core/networking/json_num_converters.dart';
import 'package:wasel_core/networking/paged/paged_list.dart';

part 'paged_list_response.g.dart';

/// Wire model for the shared `PagedListOf*` envelope.
/// [T] is the raw item response type; toEntity maps it to the domain item so
/// data models never leak past the data layer.
@JsonSerializable(genericArgumentFactories: true)
class PagedListResponse<T> {
  @JsonKey(defaultValue: <Never>[])
  final List<T> items;

  @JsonKey(fromJson: intFromJson)
  final int currentPage;

  @JsonKey(fromJson: intFromJson)
  final int totalPages;

  @JsonKey(fromJson: intFromJson)
  final int pageSize;

  @JsonKey(fromJson: intFromJson)
  final int totalCount;

  const PagedListResponse({
    required this.items,
    required this.currentPage,
    required this.totalPages,
    required this.pageSize,
    required this.totalCount,
  });

  factory PagedListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PagedListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PagedListResponseToJson(this, toJsonT);

  PagedList<E> toEntity<E>(E Function(T item) map) => PagedList<E>(
    items: items.map(map).toList(growable: false),
    currentPage: currentPage,
    totalPages: totalPages,
    pageSize: pageSize,
    totalCount: totalCount,
  );
}
