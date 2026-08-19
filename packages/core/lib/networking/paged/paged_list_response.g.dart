// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedListResponse<T> _$PagedListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PagedListResponse<T>(
  items: (json['items'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
  currentPage: intFromJson(json['currentPage']),
  totalPages: intFromJson(json['totalPages']),
  pageSize: intFromJson(json['pageSize']),
  totalCount: intFromJson(json['totalCount']),
);

Map<String, dynamic> _$PagedListResponseToJson<T>(
  PagedListResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
};
