// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_handoff_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NavigationHandoff)
final navigationHandoffProvider = NavigationHandoffProvider._();

final class NavigationHandoffProvider
    extends $AsyncNotifierProvider<NavigationHandoff, List<NavigationApp>> {
  NavigationHandoffProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navigationHandoffProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navigationHandoffHash();

  @$internal
  @override
  NavigationHandoff create() => NavigationHandoff();
}

String _$navigationHandoffHash() => r'8a6d509d1b3a1593c0481e610a98a82ced2d388e';

abstract class _$NavigationHandoff extends $AsyncNotifier<List<NavigationApp>> {
  FutureOr<List<NavigationApp>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<NavigationApp>>, List<NavigationApp>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<NavigationApp>>, List<NavigationApp>>,
              AsyncValue<List<NavigationApp>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
