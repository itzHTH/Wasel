// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_payment_method_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedPaymentMethod)
final selectedPaymentMethodProvider = SelectedPaymentMethodProvider._();

final class SelectedPaymentMethodProvider
    extends $NotifierProvider<SelectedPaymentMethod, PaymentMethod> {
  SelectedPaymentMethodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPaymentMethodProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPaymentMethodHash();

  @$internal
  @override
  SelectedPaymentMethod create() => SelectedPaymentMethod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaymentMethod value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaymentMethod>(value),
    );
  }
}

String _$selectedPaymentMethodHash() =>
    r'7efb512edec2e5f64766aaea02de31b50fb51827';

abstract class _$SelectedPaymentMethod extends $Notifier<PaymentMethod> {
  PaymentMethod build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PaymentMethod, PaymentMethod>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PaymentMethod, PaymentMethod>,
              PaymentMethod,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
