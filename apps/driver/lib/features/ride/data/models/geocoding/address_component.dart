import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_component.freezed.dart';
part 'address_component.g.dart';

@freezed
abstract class AddressComponent with _$AddressComponent {
  const factory AddressComponent({
    String? longText,
    @Default(<String>[]) List<String> types,
    String? languageCode,
  }) = _AddressComponent;

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentFromJson(json);
}
