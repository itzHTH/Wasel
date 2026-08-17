// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives the 3-step reset flow and owns the reset token between steps.
///
/// Loading lives in the state rather than an [AsyncValue] so the token survives
/// an in-flight request. Each step returns whether the caller may advance.

@ProviderFor(ResetPasswordController)
final resetPasswordControllerProvider = ResetPasswordControllerProvider._();

/// Drives the 3-step reset flow and owns the reset token between steps.
///
/// Loading lives in the state rather than an [AsyncValue] so the token survives
/// an in-flight request. Each step returns whether the caller may advance.
final class ResetPasswordControllerProvider
    extends $NotifierProvider<ResetPasswordController, ResetPasswordState> {
  /// Drives the 3-step reset flow and owns the reset token between steps.
  ///
  /// Loading lives in the state rather than an [AsyncValue] so the token survives
  /// an in-flight request. Each step returns whether the caller may advance.
  ResetPasswordControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resetPasswordControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resetPasswordControllerHash();

  @$internal
  @override
  ResetPasswordController create() => ResetPasswordController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResetPasswordState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResetPasswordState>(value),
    );
  }
}

String _$resetPasswordControllerHash() =>
    r'93a65dbe4b909603ba6af9e10586055c1fb23223';

/// Drives the 3-step reset flow and owns the reset token between steps.
///
/// Loading lives in the state rather than an [AsyncValue] so the token survives
/// an in-flight request. Each step returns whether the caller may advance.

abstract class _$ResetPasswordController extends $Notifier<ResetPasswordState> {
  ResetPasswordState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ResetPasswordState, ResetPasswordState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ResetPasswordState, ResetPasswordState>,
              ResetPasswordState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
