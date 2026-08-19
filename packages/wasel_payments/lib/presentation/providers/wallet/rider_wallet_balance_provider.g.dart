// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_wallet_balance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RiderWalletBalanceController)
final riderWalletBalanceControllerProvider =
    RiderWalletBalanceControllerProvider._();

final class RiderWalletBalanceControllerProvider
    extends
        $AsyncNotifierProvider<RiderWalletBalanceController, WalletBalance> {
  RiderWalletBalanceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: _noRetry,
        name: r'riderWalletBalanceControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riderWalletBalanceControllerHash();

  @$internal
  @override
  RiderWalletBalanceController create() => RiderWalletBalanceController();
}

String _$riderWalletBalanceControllerHash() =>
    r'7653345ab88cb977644fb3ad4bf1379e2635d81b';

abstract class _$RiderWalletBalanceController
    extends $AsyncNotifier<WalletBalance> {
  FutureOr<WalletBalance> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<WalletBalance>, WalletBalance>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<WalletBalance>, WalletBalance>,
              AsyncValue<WalletBalance>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
