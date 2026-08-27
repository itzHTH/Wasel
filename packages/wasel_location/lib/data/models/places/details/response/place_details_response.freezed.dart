// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_details_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceDetailsResponse {

 PlaceLocation? get location;
/// Create a copy of PlaceDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceDetailsResponseCopyWith<PlaceDetailsResponse> get copyWith => _$PlaceDetailsResponseCopyWithImpl<PlaceDetailsResponse>(this as PlaceDetailsResponse, _$identity);

  /// Serializes this PlaceDetailsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceDetailsResponse&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'PlaceDetailsResponse(location: $location)';
}


}

/// @nodoc
abstract mixin class $PlaceDetailsResponseCopyWith<$Res>  {
  factory $PlaceDetailsResponseCopyWith(PlaceDetailsResponse value, $Res Function(PlaceDetailsResponse) _then) = _$PlaceDetailsResponseCopyWithImpl;
@useResult
$Res call({
 PlaceLocation? location
});


$PlaceLocationCopyWith<$Res>? get location;

}
/// @nodoc
class _$PlaceDetailsResponseCopyWithImpl<$Res>
    implements $PlaceDetailsResponseCopyWith<$Res> {
  _$PlaceDetailsResponseCopyWithImpl(this._self, this._then);

  final PlaceDetailsResponse _self;
  final $Res Function(PlaceDetailsResponse) _then;

/// Create a copy of PlaceDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? location = freezed,}) {
  return _then(_self.copyWith(
location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as PlaceLocation?,
  ));
}
/// Create a copy of PlaceDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $PlaceLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaceDetailsResponse].
extension PlaceDetailsResponsePatterns on PlaceDetailsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceDetailsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceDetailsResponse value)  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceDetailsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlaceLocation? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceDetailsResponse() when $default != null:
return $default(_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlaceLocation? location)  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailsResponse():
return $default(_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlaceLocation? location)?  $default,) {final _that = this;
switch (_that) {
case _PlaceDetailsResponse() when $default != null:
return $default(_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceDetailsResponse implements PlaceDetailsResponse {
  const _PlaceDetailsResponse({this.location});
  factory _PlaceDetailsResponse.fromJson(Map<String, dynamic> json) => _$PlaceDetailsResponseFromJson(json);

@override final  PlaceLocation? location;

/// Create a copy of PlaceDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceDetailsResponseCopyWith<_PlaceDetailsResponse> get copyWith => __$PlaceDetailsResponseCopyWithImpl<_PlaceDetailsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceDetailsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceDetailsResponse&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,location);

@override
String toString() {
  return 'PlaceDetailsResponse(location: $location)';
}


}

/// @nodoc
abstract mixin class _$PlaceDetailsResponseCopyWith<$Res> implements $PlaceDetailsResponseCopyWith<$Res> {
  factory _$PlaceDetailsResponseCopyWith(_PlaceDetailsResponse value, $Res Function(_PlaceDetailsResponse) _then) = __$PlaceDetailsResponseCopyWithImpl;
@override @useResult
$Res call({
 PlaceLocation? location
});


@override $PlaceLocationCopyWith<$Res>? get location;

}
/// @nodoc
class __$PlaceDetailsResponseCopyWithImpl<$Res>
    implements _$PlaceDetailsResponseCopyWith<$Res> {
  __$PlaceDetailsResponseCopyWithImpl(this._self, this._then);

  final _PlaceDetailsResponse _self;
  final $Res Function(_PlaceDetailsResponse) _then;

/// Create a copy of PlaceDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? location = freezed,}) {
  return _then(_PlaceDetailsResponse(
location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as PlaceLocation?,
  ));
}

/// Create a copy of PlaceDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaceLocationCopyWith<$Res>? get location {
    if (_self.location == null) {
    return null;
  }

  return $PlaceLocationCopyWith<$Res>(_self.location!, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
mixin _$PlaceLocation {

 double? get latitude; double? get longitude;
/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceLocationCopyWith<PlaceLocation> get copyWith => _$PlaceLocationCopyWithImpl<PlaceLocation>(this as PlaceLocation, _$identity);

  /// Serializes this PlaceLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'PlaceLocation(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $PlaceLocationCopyWith<$Res>  {
  factory $PlaceLocationCopyWith(PlaceLocation value, $Res Function(PlaceLocation) _then) = _$PlaceLocationCopyWithImpl;
@useResult
$Res call({
 double? latitude, double? longitude
});




}
/// @nodoc
class _$PlaceLocationCopyWithImpl<$Res>
    implements $PlaceLocationCopyWith<$Res> {
  _$PlaceLocationCopyWithImpl(this._self, this._then);

  final PlaceLocation _self;
  final $Res Function(PlaceLocation) _then;

/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_self.copyWith(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceLocation].
extension PlaceLocationPatterns on PlaceLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceLocation value)  $default,){
final _that = this;
switch (_that) {
case _PlaceLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceLocation value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? latitude,  double? longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceLocation() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? latitude,  double? longitude)  $default,) {final _that = this;
switch (_that) {
case _PlaceLocation():
return $default(_that.latitude,_that.longitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? latitude,  double? longitude)?  $default,) {final _that = this;
switch (_that) {
case _PlaceLocation() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceLocation implements PlaceLocation {
  const _PlaceLocation({this.latitude, this.longitude});
  factory _PlaceLocation.fromJson(Map<String, dynamic> json) => _$PlaceLocationFromJson(json);

@override final  double? latitude;
@override final  double? longitude;

/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceLocationCopyWith<_PlaceLocation> get copyWith => __$PlaceLocationCopyWithImpl<_PlaceLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceLocation&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'PlaceLocation(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$PlaceLocationCopyWith<$Res> implements $PlaceLocationCopyWith<$Res> {
  factory _$PlaceLocationCopyWith(_PlaceLocation value, $Res Function(_PlaceLocation) _then) = __$PlaceLocationCopyWithImpl;
@override @useResult
$Res call({
 double? latitude, double? longitude
});




}
/// @nodoc
class __$PlaceLocationCopyWithImpl<$Res>
    implements _$PlaceLocationCopyWith<$Res> {
  __$PlaceLocationCopyWithImpl(this._self, this._then);

  final _PlaceLocation _self;
  final $Res Function(_PlaceLocation) _then;

/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = freezed,Object? longitude = freezed,}) {
  return _then(_PlaceLocation(
latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
