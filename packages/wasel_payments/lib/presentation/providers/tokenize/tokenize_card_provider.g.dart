// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokenize_card_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the payment token only. Card details are never stored: they live in
/// the form's controllers and are gone once the sheet is disposed.

@ProviderFor(TokenizeCardController)
final tokenizeCardControllerProvider = TokenizeCardControllerProvider._();

/// Holds the payment token only. Card details are never stored: they live in
/// the form's controllers and are gone once the sheet is disposed.
final class TokenizeCardControllerProvider
    extends $AsyncNotifierProvider<TokenizeCardController, String?> {
  /// Holds the payment token only. Card details are never stored: they live in
  /// the form's controllers and are gone once the sheet is disposed.
  TokenizeCardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenizeCardControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenizeCardControllerHash();

  @$internal
  @override
  TokenizeCardController create() => TokenizeCardController();
}

String _$tokenizeCardControllerHash() =>
    r'a356c0760fc29c808ba89d356bb9b91b812bf47e';

/// Holds the payment token only. Card details are never stored: they live in
/// the form's controllers and are gone once the sheet is disposed.

abstract class _$TokenizeCardController extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
