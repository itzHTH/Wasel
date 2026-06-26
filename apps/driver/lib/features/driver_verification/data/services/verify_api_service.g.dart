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

String _$verifyApiServiceHash() => r'38f4ea00d90eb1388f4c1c3da4e81986c23b972c';
