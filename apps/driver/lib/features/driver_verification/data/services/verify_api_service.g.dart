// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_api_service.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _VerifyApiService implements VerifyApiService {
  _VerifyApiService(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<GetVerificationStatusResponse> getVerificationStatus({
    CancelToken? cancelToken,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<GetVerificationStatusResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/api/v1/driver-profile/status',
            queryParameters: queryParameters,
            data: _data,
            cancelToken: cancelToken,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late GetVerificationStatusResponse _value;
    try {
      _value = GetVerificationStatusResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  @override
  Future<SubmitDriverProfileResponse> submitDriverProfile({
    required File licenseFront,
    required File licenseBack,
    required File selfie,
    required File vehicleImage,
    required String vehicleModel,
    required String vehicleYear,
    required String vinNumber,
    void Function(int, int)? onSendProgress,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(
      MapEntry(
        'LicenseFrontImage',
        MultipartFile.fromFileSync(
          licenseFront.path,
          filename: licenseFront.path.split(Platform.pathSeparator).last,
        ),
      ),
    );
    _data.files.add(
      MapEntry(
        'LicenseBackImage',
        MultipartFile.fromFileSync(
          licenseBack.path,
          filename: licenseBack.path.split(Platform.pathSeparator).last,
        ),
      ),
    );
    _data.files.add(
      MapEntry(
        'SelfieImage',
        MultipartFile.fromFileSync(
          selfie.path,
          filename: selfie.path.split(Platform.pathSeparator).last,
        ),
      ),
    );
    _data.files.add(
      MapEntry(
        'VehicleImage',
        MultipartFile.fromFileSync(
          vehicleImage.path,
          filename: vehicleImage.path.split(Platform.pathSeparator).last,
        ),
      ),
    );
    _data.fields.add(MapEntry('VehicleModel', vehicleModel));
    _data.fields.add(MapEntry('VehicleYear', vehicleYear));
    _data.fields.add(MapEntry('VinNumber', vinNumber));
    final newOptions = newRequestOptions(options);
    newOptions.extra.addAll(_extra);
    newOptions.headers.addAll(_dio.options.headers);
    newOptions.headers.addAll(_headers);
    final _options = newOptions.copyWith(
      method: 'POST',
      contentType: 'multipart/form-data',
      baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
      queryParameters: queryParameters,
      path: '/api/v1/driver-profile/submit',
    )..data = _data;
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late SubmitDriverProfileResponse _value;
    try {
      _value = SubmitDriverProfileResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    return _value;
  }

  RequestOptions newRequestOptions(Object? options) {
    if (options is RequestOptions) {
      return options;
    }
    if (options is Options) {
      return RequestOptions(
        method: options.method,
        sendTimeout: options.sendTimeout,
        receiveTimeout: options.receiveTimeout,
        extra: options.extra,
        headers: options.headers,
        responseType: options.responseType,
        contentType: options.contentType.toString(),
        validateStatus: options.validateStatus,
        receiveDataWhenStatusError: options.receiveDataWhenStatusError,
        followRedirects: options.followRedirects,
        maxRedirects: options.maxRedirects,
        requestEncoder: options.requestEncoder,
        responseDecoder: options.responseDecoder,
        path: '',
      );
    }
    return RequestOptions(path: '');
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(verifyApiService)
final verifyApiServiceProvider = VerifyApiServiceProvider._();

final class VerifyApiServiceProvider
    extends
        $FunctionalProvider<
          VerifyApiService,
          VerifyApiService,
          VerifyApiService
        >
    with $Provider<VerifyApiService> {
  VerifyApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verifyApiServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verifyApiServiceHash();

  @$internal
  @override
  $ProviderElement<VerifyApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VerifyApiService create(Ref ref) {
    return verifyApiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VerifyApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VerifyApiService>(value),
    );
  }
}

String _$verifyApiServiceHash() => r'48221e2d16aced71fdc4337a6afaad31435ae261';
