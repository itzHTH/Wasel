import 'package:json_annotation/json_annotation.dart';

part 'update_rider_profile_body.g.dart';

@JsonSerializable(createFactory: false)
class UpdateRiderProfileBody {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const UpdateRiderProfileBody({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => _$UpdateRiderProfileBodyToJson(this);
}
