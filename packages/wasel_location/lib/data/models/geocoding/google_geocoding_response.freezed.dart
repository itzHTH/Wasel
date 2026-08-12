// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_geocoding_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GoogleGeocodingResponse {

 List<GeocodeResult> get results;
/// Create a copy of GoogleGeocodingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoogleGeocodingResponseCopyWith<GoogleGeocodingResponse> get copyWith => _$GoogleGeocodingResponseCopyWithImpl<GoogleGeocodingResponse>(this as GoogleGeocodingResponse, _$identity);

  /// Serializes this GoogleGeocodingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleGeocodingResponse&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'GoogleGeocodingResponse(results: $results)';
}


}

/// @nodoc
abstract mixin class $GoogleGeocodingResponseCopyWith<$Res>  {
  factory $GoogleGeocodingResponseCopyWith(GoogleGeocodingResponse value, $Res Function(GoogleGeocodingResponse) _then) = _$GoogleGeocodingResponseCopyWithImpl;
@useResult
$Res call({
 List<GeocodeResult> results
});




}
/// @nodoc
class _$GoogleGeocodingResponseCopyWithImpl<$Res>
    implements $GoogleGeocodingResponseCopyWith<$Res> {
  _$GoogleGeocodingResponseCopyWithImpl(this._self, this._then);

  final GoogleGeocodingResponse _self;
  final $Res Function(GoogleGeocodingResponse) _then;

/// Create a copy of GoogleGeocodingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = null,}) {
  return _then(_self.copyWith(
results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<GeocodeResult>,
  ));
}

}


/// Adds pattern-matching-related methods to [GoogleGeocodingResponse].
extension GoogleGeocodingResponsePatterns on GoogleGeocodingResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoogleGeocodingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoogleGeocodingResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoogleGeocodingResponse value)  $default,){
final _that = this;
switch (_that) {
case _GoogleGeocodingResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoogleGeocodingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _GoogleGeocodingResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GeocodeResult> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoogleGeocodingResponse() when $default != null:
return $default(_that.results);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GeocodeResult> results)  $default,) {final _that = this;
switch (_that) {
case _GoogleGeocodingResponse():
return $default(_that.results);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GeocodeResult> results)?  $default,) {final _that = this;
switch (_that) {
case _GoogleGeocodingResponse() when $default != null:
return $default(_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoogleGeocodingResponse implements GoogleGeocodingResponse {
  const _GoogleGeocodingResponse({final  List<GeocodeResult> results = const <GeocodeResult>[]}): _results = results;
  factory _GoogleGeocodingResponse.fromJson(Map<String, dynamic> json) => _$GoogleGeocodingResponseFromJson(json);

 final  List<GeocodeResult> _results;
@override@JsonKey() List<GeocodeResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of GoogleGeocodingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoogleGeocodingResponseCopyWith<_GoogleGeocodingResponse> get copyWith => __$GoogleGeocodingResponseCopyWithImpl<_GoogleGeocodingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoogleGeocodingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoogleGeocodingResponse&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'GoogleGeocodingResponse(results: $results)';
}


}

/// @nodoc
abstract mixin class _$GoogleGeocodingResponseCopyWith<$Res> implements $GoogleGeocodingResponseCopyWith<$Res> {
  factory _$GoogleGeocodingResponseCopyWith(_GoogleGeocodingResponse value, $Res Function(_GoogleGeocodingResponse) _then) = __$GoogleGeocodingResponseCopyWithImpl;
@override @useResult
$Res call({
 List<GeocodeResult> results
});




}
/// @nodoc
class __$GoogleGeocodingResponseCopyWithImpl<$Res>
    implements _$GoogleGeocodingResponseCopyWith<$Res> {
  __$GoogleGeocodingResponseCopyWithImpl(this._self, this._then);

  final _GoogleGeocodingResponse _self;
  final $Res Function(_GoogleGeocodingResponse) _then;

/// Create a copy of GoogleGeocodingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = null,}) {
  return _then(_GoogleGeocodingResponse(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<GeocodeResult>,
  ));
}


}


/// @nodoc
mixin _$GeocodeResult {

 List<AddressComponent> get addressComponents;
/// Create a copy of GeocodeResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeocodeResultCopyWith<GeocodeResult> get copyWith => _$GeocodeResultCopyWithImpl<GeocodeResult>(this as GeocodeResult, _$identity);

  /// Serializes this GeocodeResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeocodeResult&&const DeepCollectionEquality().equals(other.addressComponents, addressComponents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(addressComponents));

@override
String toString() {
  return 'GeocodeResult(addressComponents: $addressComponents)';
}


}

/// @nodoc
abstract mixin class $GeocodeResultCopyWith<$Res>  {
  factory $GeocodeResultCopyWith(GeocodeResult value, $Res Function(GeocodeResult) _then) = _$GeocodeResultCopyWithImpl;
@useResult
$Res call({
 List<AddressComponent> addressComponents
});




}
/// @nodoc
class _$GeocodeResultCopyWithImpl<$Res>
    implements $GeocodeResultCopyWith<$Res> {
  _$GeocodeResultCopyWithImpl(this._self, this._then);

  final GeocodeResult _self;
  final $Res Function(GeocodeResult) _then;

/// Create a copy of GeocodeResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? addressComponents = null,}) {
  return _then(_self.copyWith(
addressComponents: null == addressComponents ? _self.addressComponents : addressComponents // ignore: cast_nullable_to_non_nullable
as List<AddressComponent>,
  ));
}

}


/// Adds pattern-matching-related methods to [GeocodeResult].
extension GeocodeResultPatterns on GeocodeResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeocodeResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeocodeResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeocodeResult value)  $default,){
final _that = this;
switch (_that) {
case _GeocodeResult():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeocodeResult value)?  $default,){
final _that = this;
switch (_that) {
case _GeocodeResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AddressComponent> addressComponents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeocodeResult() when $default != null:
return $default(_that.addressComponents);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AddressComponent> addressComponents)  $default,) {final _that = this;
switch (_that) {
case _GeocodeResult():
return $default(_that.addressComponents);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AddressComponent> addressComponents)?  $default,) {final _that = this;
switch (_that) {
case _GeocodeResult() when $default != null:
return $default(_that.addressComponents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeocodeResult implements GeocodeResult {
  const _GeocodeResult({final  List<AddressComponent> addressComponents = const <AddressComponent>[]}): _addressComponents = addressComponents;
  factory _GeocodeResult.fromJson(Map<String, dynamic> json) => _$GeocodeResultFromJson(json);

 final  List<AddressComponent> _addressComponents;
@override@JsonKey() List<AddressComponent> get addressComponents {
  if (_addressComponents is EqualUnmodifiableListView) return _addressComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addressComponents);
}


/// Create a copy of GeocodeResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeocodeResultCopyWith<_GeocodeResult> get copyWith => __$GeocodeResultCopyWithImpl<_GeocodeResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeocodeResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeocodeResult&&const DeepCollectionEquality().equals(other._addressComponents, _addressComponents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_addressComponents));

@override
String toString() {
  return 'GeocodeResult(addressComponents: $addressComponents)';
}


}

/// @nodoc
abstract mixin class _$GeocodeResultCopyWith<$Res> implements $GeocodeResultCopyWith<$Res> {
  factory _$GeocodeResultCopyWith(_GeocodeResult value, $Res Function(_GeocodeResult) _then) = __$GeocodeResultCopyWithImpl;
@override @useResult
$Res call({
 List<AddressComponent> addressComponents
});




}
/// @nodoc
class __$GeocodeResultCopyWithImpl<$Res>
    implements _$GeocodeResultCopyWith<$Res> {
  __$GeocodeResultCopyWithImpl(this._self, this._then);

  final _GeocodeResult _self;
  final $Res Function(_GeocodeResult) _then;

/// Create a copy of GeocodeResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? addressComponents = null,}) {
  return _then(_GeocodeResult(
addressComponents: null == addressComponents ? _self._addressComponents : addressComponents // ignore: cast_nullable_to_non_nullable
as List<AddressComponent>,
  ));
}


}

// dart format on
