// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_photo_upload_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RiderPhotoUpload)
final riderPhotoUploadProvider = RiderPhotoUploadProvider._();

final class RiderPhotoUploadProvider
    extends $AsyncNotifierProvider<RiderPhotoUpload, String?> {
  RiderPhotoUploadProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'riderPhotoUploadProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riderPhotoUploadHash();

  @$internal
  @override
  RiderPhotoUpload create() => RiderPhotoUpload();
}

String _$riderPhotoUploadHash() => r'2d8fa7798132afefa700fe5e943056e6eeb2702d';

abstract class _$RiderPhotoUpload extends $AsyncNotifier<String?> {
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
