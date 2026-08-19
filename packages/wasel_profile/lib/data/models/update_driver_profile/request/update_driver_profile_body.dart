import 'package:json_annotation/json_annotation.dart';

part 'update_driver_profile_body.g.dart';

@JsonSerializable(createFactory: false)
class UpdateDriverProfileBody {
  final String phoneNumber;

  const UpdateDriverProfileBody({required this.phoneNumber});

  Map<String, dynamic> toJson() => _$UpdateDriverProfileBodyToJson(this);
}
