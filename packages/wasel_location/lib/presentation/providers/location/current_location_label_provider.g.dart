// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_location_label_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A human-readable name for where the rider is standing, for pre-filling a
/// pickup field.
///
/// Never fails: a missing fix, a denied permission, a nameless point or a
/// geocoder error all fall back to "my current location", which is still true
/// and still selectable. A pickup field showing an error is worse than one
/// showing a generic label.

@ProviderFor(currentLocationLabel)
final currentLocationLabelProvider = CurrentLocationLabelProvider._();

/// A human-readable name for where the rider is standing, for pre-filling a
/// pickup field.
///
/// Never fails: a missing fix, a denied permission, a nameless point or a
/// geocoder error all fall back to "my current location", which is still true
/// and still selectable. A pickup field showing an error is worse than one
/// showing a generic label.

final class CurrentLocationLabelProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// A human-readable name for where the rider is standing, for pre-filling a
  /// pickup field.
  ///
  /// Never fails: a missing fix, a denied permission, a nameless point or a
  /// geocoder error all fall back to "my current location", which is still true
  /// and still selectable. A pickup field showing an error is worse than one
  /// showing a generic label.
  CurrentLocationLabelProvider._()
    : super(
        from: null,
        argument: null,
        retry: _noRetry,
        name: r'currentLocationLabelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentLocationLabelHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return currentLocationLabel(ref);
  }
}

String _$currentLocationLabelHash() =>
    r'b5b1992944e4e877f9a664227d069d34a9b8f87f';
