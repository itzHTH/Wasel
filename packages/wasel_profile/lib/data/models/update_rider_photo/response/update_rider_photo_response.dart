import 'package:json_annotation/json_annotation.dart';

part 'update_rider_photo_response.g.dart';

@JsonSerializable()
class UpdateRiderPhotoResponse {
  @JsonKey(name: "data")
  final String? photoUrl;

  UpdateRiderPhotoResponse({this.photoUrl});

  factory UpdateRiderPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateRiderPhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRiderPhotoResponseToJson(this);

  String? toEntity() => photoUrl;
}
