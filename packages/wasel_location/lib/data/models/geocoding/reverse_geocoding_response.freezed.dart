// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reverse_geocoding_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReverseGeocodingResponse {

 List<GeocodingResult> get results; String? get status;
/// Create a copy of ReverseGeocodingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReverseGeocodingResponseCopyWith<ReverseGeocodingResponse> get copyWith => _$ReverseGeocodingResponseCopyWithImpl<ReverseGeocodingResponse>(this as ReverseGeocodingResponse, _$identity);

  /// Serializes this ReverseGeocodingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReverseGeocodingResponse&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(results),status);

@override
String toString() {
  return 'ReverseGeocodingResponse(results: $results, status: $status)';
}


}

/// @nodoc
abstract mixin class $ReverseGeocodingResponseCopyWith<$Res>  {
  factory $ReverseGeocodingResponseCopyWith(ReverseGeocodingResponse value, $Res Function(ReverseGeocodingResponse) _then) = _$ReverseGeocodingResponseCopyWithImpl;
@useResult
$Res call({
 List<GeocodingResult> results, String? status
});




}
/// @nodoc
class _$ReverseGeocodingResponseCopyWithImpl<$Res>
    implements $ReverseGeocodingResponseCopyWith<$Res> {
  _$ReverseGeocodingResponseCopyWithImpl(this._self, this._then);

  final ReverseGeocodingResponse _self;
  final $Res Function(ReverseGeocodingResponse) _then;

/// Create a copy of ReverseGeocodingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = null,Object? status = freezed,}) {
  return _then(_self.copyWith(
results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<GeocodingResult>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReverseGeocodingResponse].
extension ReverseGeocodingResponsePatterns on ReverseGeocodingResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReverseGeocodingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReverseGeocodingResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReverseGeocodingResponse value)  $default,){
final _that = this;
switch (_that) {
case _ReverseGeocodingResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReverseGeocodingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ReverseGeocodingResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<GeocodingResult> results,  String? status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReverseGeocodingResponse() when $default != null:
return $default(_that.results,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<GeocodingResult> results,  String? status)  $default,) {final _that = this;
switch (_that) {
case _ReverseGeocodingResponse():
return $default(_that.results,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<GeocodingResult> results,  String? status)?  $default,) {final _that = this;
switch (_that) {
case _ReverseGeocodingResponse() when $default != null:
return $default(_that.results,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReverseGeocodingResponse implements ReverseGeocodingResponse {
  const _ReverseGeocodingResponse({final  List<GeocodingResult> results = const <GeocodingResult>[], this.status}): _results = results;
  factory _ReverseGeocodingResponse.fromJson(Map<String, dynamic> json) => _$ReverseGeocodingResponseFromJson(json);

 final  List<GeocodingResult> _results;
@override@JsonKey() List<GeocodingResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override final  String? status;

/// Create a copy of ReverseGeocodingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReverseGeocodingResponseCopyWith<_ReverseGeocodingResponse> get copyWith => __$ReverseGeocodingResponseCopyWithImpl<_ReverseGeocodingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReverseGeocodingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReverseGeocodingResponse&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results),status);

@override
String toString() {
  return 'ReverseGeocodingResponse(results: $results, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ReverseGeocodingResponseCopyWith<$Res> implements $ReverseGeocodingResponseCopyWith<$Res> {
  factory _$ReverseGeocodingResponseCopyWith(_ReverseGeocodingResponse value, $Res Function(_ReverseGeocodingResponse) _then) = __$ReverseGeocodingResponseCopyWithImpl;
@override @useResult
$Res call({
 List<GeocodingResult> results, String? status
});




}
/// @nodoc
class __$ReverseGeocodingResponseCopyWithImpl<$Res>
    implements _$ReverseGeocodingResponseCopyWith<$Res> {
  __$ReverseGeocodingResponseCopyWithImpl(this._self, this._then);

  final _ReverseGeocodingResponse _self;
  final $Res Function(_ReverseGeocodingResponse) _then;

/// Create a copy of ReverseGeocodingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = null,Object? status = freezed,}) {
  return _then(_ReverseGeocodingResponse(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<GeocodingResult>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GeocodingResult {

@JsonKey(name: 'address_components') List<AddressComponent> get addressComponents; List<String> get types;
/// Create a copy of GeocodingResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeocodingResultCopyWith<GeocodingResult> get copyWith => _$GeocodingResultCopyWithImpl<GeocodingResult>(this as GeocodingResult, _$identity);

  /// Serializes this GeocodingResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GeocodingResult&&const DeepCollectionEquality().equals(other.addressComponents, addressComponents)&&const DeepCollectionEquality().equals(other.types, types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(addressComponents),const DeepCollectionEquality().hash(types));

@override
String toString() {
  return 'GeocodingResult(addressComponents: $addressComponents, types: $types)';
}


}

/// @nodoc
abstract mixin class $GeocodingResultCopyWith<$Res>  {
  factory $GeocodingResultCopyWith(GeocodingResult value, $Res Function(GeocodingResult) _then) = _$GeocodingResultCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'address_components') List<AddressComponent> addressComponents, List<String> types
});




}
/// @nodoc
class _$GeocodingResultCopyWithImpl<$Res>
    implements $GeocodingResultCopyWith<$Res> {
  _$GeocodingResultCopyWithImpl(this._self, this._then);

  final GeocodingResult _self;
  final $Res Function(GeocodingResult) _then;

/// Create a copy of GeocodingResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? addressComponents = null,Object? types = null,}) {
  return _then(_self.copyWith(
addressComponents: null == addressComponents ? _self.addressComponents : addressComponents // ignore: cast_nullable_to_non_nullable
as List<AddressComponent>,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [GeocodingResult].
extension GeocodingResultPatterns on GeocodingResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GeocodingResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GeocodingResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GeocodingResult value)  $default,){
final _that = this;
switch (_that) {
case _GeocodingResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GeocodingResult value)?  $default,){
final _that = this;
switch (_that) {
case _GeocodingResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'address_components')  List<AddressComponent> addressComponents,  List<String> types)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GeocodingResult() when $default != null:
return $default(_that.addressComponents,_that.types);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'address_components')  List<AddressComponent> addressComponents,  List<String> types)  $default,) {final _that = this;
switch (_that) {
case _GeocodingResult():
return $default(_that.addressComponents,_that.types);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'address_components')  List<AddressComponent> addressComponents,  List<String> types)?  $default,) {final _that = this;
switch (_that) {
case _GeocodingResult() when $default != null:
return $default(_that.addressComponents,_that.types);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GeocodingResult implements GeocodingResult {
  const _GeocodingResult({@JsonKey(name: 'address_components') final  List<AddressComponent> addressComponents = const <AddressComponent>[], final  List<String> types = const <String>[]}): _addressComponents = addressComponents,_types = types;
  factory _GeocodingResult.fromJson(Map<String, dynamic> json) => _$GeocodingResultFromJson(json);

 final  List<AddressComponent> _addressComponents;
@override@JsonKey(name: 'address_components') List<AddressComponent> get addressComponents {
  if (_addressComponents is EqualUnmodifiableListView) return _addressComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addressComponents);
}

 final  List<String> _types;
@override@JsonKey() List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}


/// Create a copy of GeocodingResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeocodingResultCopyWith<_GeocodingResult> get copyWith => __$GeocodingResultCopyWithImpl<_GeocodingResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GeocodingResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeocodingResult&&const DeepCollectionEquality().equals(other._addressComponents, _addressComponents)&&const DeepCollectionEquality().equals(other._types, _types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_addressComponents),const DeepCollectionEquality().hash(_types));

@override
String toString() {
  return 'GeocodingResult(addressComponents: $addressComponents, types: $types)';
}


}

/// @nodoc
abstract mixin class _$GeocodingResultCopyWith<$Res> implements $GeocodingResultCopyWith<$Res> {
  factory _$GeocodingResultCopyWith(_GeocodingResult value, $Res Function(_GeocodingResult) _then) = __$GeocodingResultCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'address_components') List<AddressComponent> addressComponents, List<String> types
});




}
/// @nodoc
class __$GeocodingResultCopyWithImpl<$Res>
    implements _$GeocodingResultCopyWith<$Res> {
  __$GeocodingResultCopyWithImpl(this._self, this._then);

  final _GeocodingResult _self;
  final $Res Function(_GeocodingResult) _then;

/// Create a copy of GeocodingResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? addressComponents = null,Object? types = null,}) {
  return _then(_GeocodingResult(
addressComponents: null == addressComponents ? _self._addressComponents : addressComponents // ignore: cast_nullable_to_non_nullable
as List<AddressComponent>,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$AddressComponent {

@JsonKey(name: 'long_name') String? get longName; List<String> get types;
/// Create a copy of AddressComponent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressComponentCopyWith<AddressComponent> get copyWith => _$AddressComponentCopyWithImpl<AddressComponent>(this as AddressComponent, _$identity);

  /// Serializes this AddressComponent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressComponent&&(identical(other.longName, longName) || other.longName == longName)&&const DeepCollectionEquality().equals(other.types, types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,longName,const DeepCollectionEquality().hash(types));

@override
String toString() {
  return 'AddressComponent(longName: $longName, types: $types)';
}


}

/// @nodoc
abstract mixin class $AddressComponentCopyWith<$Res>  {
  factory $AddressComponentCopyWith(AddressComponent value, $Res Function(AddressComponent) _then) = _$AddressComponentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'long_name') String? longName, List<String> types
});




}
/// @nodoc
class _$AddressComponentCopyWithImpl<$Res>
    implements $AddressComponentCopyWith<$Res> {
  _$AddressComponentCopyWithImpl(this._self, this._then);

  final AddressComponent _self;
  final $Res Function(AddressComponent) _then;

/// Create a copy of AddressComponent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? longName = freezed,Object? types = null,}) {
  return _then(_self.copyWith(
longName: freezed == longName ? _self.longName : longName // ignore: cast_nullable_to_non_nullable
as String?,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AddressComponent].
extension AddressComponentPatterns on AddressComponent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddressComponent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddressComponent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddressComponent value)  $default,){
final _that = this;
switch (_that) {
case _AddressComponent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddressComponent value)?  $default,){
final _that = this;
switch (_that) {
case _AddressComponent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'long_name')  String? longName,  List<String> types)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressComponent() when $default != null:
return $default(_that.longName,_that.types);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'long_name')  String? longName,  List<String> types)  $default,) {final _that = this;
switch (_that) {
case _AddressComponent():
return $default(_that.longName,_that.types);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'long_name')  String? longName,  List<String> types)?  $default,) {final _that = this;
switch (_that) {
case _AddressComponent() when $default != null:
return $default(_that.longName,_that.types);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddressComponent implements AddressComponent {
  const _AddressComponent({@JsonKey(name: 'long_name') this.longName, final  List<String> types = const <String>[]}): _types = types;
  factory _AddressComponent.fromJson(Map<String, dynamic> json) => _$AddressComponentFromJson(json);

@override@JsonKey(name: 'long_name') final  String? longName;
 final  List<String> _types;
@override@JsonKey() List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}


/// Create a copy of AddressComponent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddressComponentCopyWith<_AddressComponent> get copyWith => __$AddressComponentCopyWithImpl<_AddressComponent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AddressComponentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressComponent&&(identical(other.longName, longName) || other.longName == longName)&&const DeepCollectionEquality().equals(other._types, _types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,longName,const DeepCollectionEquality().hash(_types));

@override
String toString() {
  return 'AddressComponent(longName: $longName, types: $types)';
}


}

/// @nodoc
abstract mixin class _$AddressComponentCopyWith<$Res> implements $AddressComponentCopyWith<$Res> {
  factory _$AddressComponentCopyWith(_AddressComponent value, $Res Function(_AddressComponent) _then) = __$AddressComponentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'long_name') String? longName, List<String> types
});




}
/// @nodoc
class __$AddressComponentCopyWithImpl<$Res>
    implements _$AddressComponentCopyWith<$Res> {
  __$AddressComponentCopyWithImpl(this._self, this._then);

  final _AddressComponent _self;
  final $Res Function(_AddressComponent) _then;

/// Create a copy of AddressComponent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? longName = freezed,Object? types = null,}) {
  return _then(_AddressComponent(
longName: freezed == longName ? _self.longName : longName // ignore: cast_nullable_to_non_nullable
as String?,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
