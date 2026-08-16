import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_component.freezed.dart';
part 'address_component.g.dart';

/// One labelled piece of an address as Google returns it.
///
/// Google emits the same component several times, once per available language,
/// distinguished only by [languageCode] — which is why the label parser cannot
/// simply take the first match and has to prefer the Arabic spelling.
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
