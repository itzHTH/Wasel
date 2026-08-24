// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_ride_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReviewRideController)
final reviewRideControllerProvider = ReviewRideControllerProvider._();

final class ReviewRideControllerProvider
    extends $AsyncNotifierProvider<ReviewRideController, ReviewRide?> {
  ReviewRideControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reviewRideControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reviewRideControllerHash();

  @$internal
  @override
  ReviewRideController create() => ReviewRideController();
}

String _$reviewRideControllerHash() =>
    r'1dd35be053a9ac780e6d592907c9c09ea7d754a2';

abstract class _$ReviewRideController extends $AsyncNotifier<ReviewRide?> {
  FutureOr<ReviewRide?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ReviewRide?>, ReviewRide?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReviewRide?>, ReviewRide?>,
              AsyncValue<ReviewRide?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
