// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signalr_client_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signalRClient)
final signalRClientProvider = SignalRClientProvider._();

final class SignalRClientProvider
    extends $FunctionalProvider<ISignalRClient, ISignalRClient, ISignalRClient>
    with $Provider<ISignalRClient> {
  SignalRClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signalRClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signalRClientHash();

  @$internal
  @override
  $ProviderElement<ISignalRClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ISignalRClient create(Ref ref) {
    return signalRClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ISignalRClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ISignalRClient>(value),
    );
  }
}

String _$signalRClientHash() => r'5d397d373cc26ce80e96515432dbddca53f5d35b';
