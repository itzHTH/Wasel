// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_search_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NearbySearchResponse {

 List<NearbyPlace> get places;
/// Create a copy of NearbySearchResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbySearchResponseCopyWith<NearbySearchResponse> get copyWith => _$NearbySearchResponseCopyWithImpl<NearbySearchResponse>(this as NearbySearchResponse, _$identity);

  /// Serializes this NearbySearchResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbySearchResponse&&const DeepCollectionEquality().equals(other.places, places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(places));

@override
String toString() {
  return 'NearbySearchResponse(places: $places)';
}


}

/// @nodoc
abstract mixin class $NearbySearchResponseCopyWith<$Res>  {
  factory $NearbySearchResponseCopyWith(NearbySearchResponse value, $Res Function(NearbySearchResponse) _then) = _$NearbySearchResponseCopyWithImpl;
@useResult
$Res call({
 List<NearbyPlace> places
});




}
/// @nodoc
class _$NearbySearchResponseCopyWithImpl<$Res>
    implements $NearbySearchResponseCopyWith<$Res> {
  _$NearbySearchResponseCopyWithImpl(this._self, this._then);

  final NearbySearchResponse _self;
  final $Res Function(NearbySearchResponse) _then;

/// Create a copy of NearbySearchResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? places = null,}) {
  return _then(_self.copyWith(
places: null == places ? _self.places : places // ignore: cast_nullable_to_non_nullable
as List<NearbyPlace>,
  ));
}

}


/// Adds pattern-matching-related methods to [NearbySearchResponse].
extension NearbySearchResponsePatterns on NearbySearchResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbySearchResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbySearchResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbySearchResponse value)  $default,){
final _that = this;
switch (_that) {
case _NearbySearchResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbySearchResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NearbySearchResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<NearbyPlace> places)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbySearchResponse() when $default != null:
return $default(_that.places);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<NearbyPlace> places)  $default,) {final _that = this;
switch (_that) {
case _NearbySearchResponse():
return $default(_that.places);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<NearbyPlace> places)?  $default,) {final _that = this;
switch (_that) {
case _NearbySearchResponse() when $default != null:
return $default(_that.places);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbySearchResponse implements NearbySearchResponse {
  const _NearbySearchResponse({final  List<NearbyPlace> places = const <NearbyPlace>[]}): _places = places;
  factory _NearbySearchResponse.fromJson(Map<String, dynamic> json) => _$NearbySearchResponseFromJson(json);

 final  List<NearbyPlace> _places;
@override@JsonKey() List<NearbyPlace> get places {
  if (_places is EqualUnmodifiableListView) return _places;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_places);
}


/// Create a copy of NearbySearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbySearchResponseCopyWith<_NearbySearchResponse> get copyWith => __$NearbySearchResponseCopyWithImpl<_NearbySearchResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbySearchResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbySearchResponse&&const DeepCollectionEquality().equals(other._places, _places));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_places));

@override
String toString() {
  return 'NearbySearchResponse(places: $places)';
}


}

/// @nodoc
abstract mixin class _$NearbySearchResponseCopyWith<$Res> implements $NearbySearchResponseCopyWith<$Res> {
  factory _$NearbySearchResponseCopyWith(_NearbySearchResponse value, $Res Function(_NearbySearchResponse) _then) = __$NearbySearchResponseCopyWithImpl;
@override @useResult
$Res call({
 List<NearbyPlace> places
});




}
/// @nodoc
class __$NearbySearchResponseCopyWithImpl<$Res>
    implements _$NearbySearchResponseCopyWith<$Res> {
  __$NearbySearchResponseCopyWithImpl(this._self, this._then);

  final _NearbySearchResponse _self;
  final $Res Function(_NearbySearchResponse) _then;

/// Create a copy of NearbySearchResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? places = null,}) {
  return _then(_NearbySearchResponse(
places: null == places ? _self._places : places // ignore: cast_nullable_to_non_nullable
as List<NearbyPlace>,
  ));
}


}


/// @nodoc
mixin _$NearbyPlace {

 String? get id; NearbyDisplayName? get displayName; String? get formattedAddress;
/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyPlaceCopyWith<NearbyPlace> get copyWith => _$NearbyPlaceCopyWithImpl<NearbyPlace>(this as NearbyPlace, _$identity);

  /// Serializes this NearbyPlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,formattedAddress);

@override
String toString() {
  return 'NearbyPlace(id: $id, displayName: $displayName, formattedAddress: $formattedAddress)';
}


}

/// @nodoc
abstract mixin class $NearbyPlaceCopyWith<$Res>  {
  factory $NearbyPlaceCopyWith(NearbyPlace value, $Res Function(NearbyPlace) _then) = _$NearbyPlaceCopyWithImpl;
@useResult
$Res call({
 String? id, NearbyDisplayName? displayName, String? formattedAddress
});


$NearbyDisplayNameCopyWith<$Res>? get displayName;

}
/// @nodoc
class _$NearbyPlaceCopyWithImpl<$Res>
    implements $NearbyPlaceCopyWith<$Res> {
  _$NearbyPlaceCopyWithImpl(this._self, this._then);

  final NearbyPlace _self;
  final $Res Function(NearbyPlace) _then;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? displayName = freezed,Object? formattedAddress = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as NearbyDisplayName?,formattedAddress: freezed == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NearbyDisplayNameCopyWith<$Res>? get displayName {
    if (_self.displayName == null) {
    return null;
  }

  return $NearbyDisplayNameCopyWith<$Res>(_self.displayName!, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}
}


/// Adds pattern-matching-related methods to [NearbyPlace].
extension NearbyPlacePatterns on NearbyPlace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyPlace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyPlace value)  $default,){
final _that = this;
switch (_that) {
case _NearbyPlace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyPlace value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  NearbyDisplayName? displayName,  String? formattedAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that.id,_that.displayName,_that.formattedAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  NearbyDisplayName? displayName,  String? formattedAddress)  $default,) {final _that = this;
switch (_that) {
case _NearbyPlace():
return $default(_that.id,_that.displayName,_that.formattedAddress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  NearbyDisplayName? displayName,  String? formattedAddress)?  $default,) {final _that = this;
switch (_that) {
case _NearbyPlace() when $default != null:
return $default(_that.id,_that.displayName,_that.formattedAddress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbyPlace implements NearbyPlace {
  const _NearbyPlace({this.id, this.displayName, this.formattedAddress});
  factory _NearbyPlace.fromJson(Map<String, dynamic> json) => _$NearbyPlaceFromJson(json);

@override final  String? id;
@override final  NearbyDisplayName? displayName;
@override final  String? formattedAddress;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyPlaceCopyWith<_NearbyPlace> get copyWith => __$NearbyPlaceCopyWithImpl<_NearbyPlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbyPlaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyPlace&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,formattedAddress);

@override
String toString() {
  return 'NearbyPlace(id: $id, displayName: $displayName, formattedAddress: $formattedAddress)';
}


}

/// @nodoc
abstract mixin class _$NearbyPlaceCopyWith<$Res> implements $NearbyPlaceCopyWith<$Res> {
  factory _$NearbyPlaceCopyWith(_NearbyPlace value, $Res Function(_NearbyPlace) _then) = __$NearbyPlaceCopyWithImpl;
@override @useResult
$Res call({
 String? id, NearbyDisplayName? displayName, String? formattedAddress
});


@override $NearbyDisplayNameCopyWith<$Res>? get displayName;

}
/// @nodoc
class __$NearbyPlaceCopyWithImpl<$Res>
    implements _$NearbyPlaceCopyWith<$Res> {
  __$NearbyPlaceCopyWithImpl(this._self, this._then);

  final _NearbyPlace _self;
  final $Res Function(_NearbyPlace) _then;

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? displayName = freezed,Object? formattedAddress = freezed,}) {
  return _then(_NearbyPlace(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as NearbyDisplayName?,formattedAddress: freezed == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of NearbyPlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NearbyDisplayNameCopyWith<$Res>? get displayName {
    if (_self.displayName == null) {
    return null;
  }

  return $NearbyDisplayNameCopyWith<$Res>(_self.displayName!, (value) {
    return _then(_self.copyWith(displayName: value));
  });
}
}


/// @nodoc
mixin _$NearbyDisplayName {

 String? get text;
/// Create a copy of NearbyDisplayName
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyDisplayNameCopyWith<NearbyDisplayName> get copyWith => _$NearbyDisplayNameCopyWithImpl<NearbyDisplayName>(this as NearbyDisplayName, _$identity);

  /// Serializes this NearbyDisplayName to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyDisplayName&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'NearbyDisplayName(text: $text)';
}


}

/// @nodoc
abstract mixin class $NearbyDisplayNameCopyWith<$Res>  {
  factory $NearbyDisplayNameCopyWith(NearbyDisplayName value, $Res Function(NearbyDisplayName) _then) = _$NearbyDisplayNameCopyWithImpl;
@useResult
$Res call({
 String? text
});




}
/// @nodoc
class _$NearbyDisplayNameCopyWithImpl<$Res>
    implements $NearbyDisplayNameCopyWith<$Res> {
  _$NearbyDisplayNameCopyWithImpl(this._self, this._then);

  final NearbyDisplayName _self;
  final $Res Function(NearbyDisplayName) _then;

/// Create a copy of NearbyDisplayName
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,}) {
  return _then(_self.copyWith(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NearbyDisplayName].
extension NearbyDisplayNamePatterns on NearbyDisplayName {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyDisplayName value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyDisplayName() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyDisplayName value)  $default,){
final _that = this;
switch (_that) {
case _NearbyDisplayName():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyDisplayName value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyDisplayName() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyDisplayName() when $default != null:
return $default(_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? text)  $default,) {final _that = this;
switch (_that) {
case _NearbyDisplayName():
return $default(_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? text)?  $default,) {final _that = this;
switch (_that) {
case _NearbyDisplayName() when $default != null:
return $default(_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbyDisplayName implements NearbyDisplayName {
  const _NearbyDisplayName({this.text});
  factory _NearbyDisplayName.fromJson(Map<String, dynamic> json) => _$NearbyDisplayNameFromJson(json);

@override final  String? text;

/// Create a copy of NearbyDisplayName
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyDisplayNameCopyWith<_NearbyDisplayName> get copyWith => __$NearbyDisplayNameCopyWithImpl<_NearbyDisplayName>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbyDisplayNameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyDisplayName&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'NearbyDisplayName(text: $text)';
}


}

/// @nodoc
abstract mixin class _$NearbyDisplayNameCopyWith<$Res> implements $NearbyDisplayNameCopyWith<$Res> {
  factory _$NearbyDisplayNameCopyWith(_NearbyDisplayName value, $Res Function(_NearbyDisplayName) _then) = __$NearbyDisplayNameCopyWithImpl;
@override @useResult
$Res call({
 String? text
});




}
/// @nodoc
class __$NearbyDisplayNameCopyWithImpl<$Res>
    implements _$NearbyDisplayNameCopyWith<$Res> {
  __$NearbyDisplayNameCopyWithImpl(this._self, this._then);

  final _NearbyDisplayName _self;
  final $Res Function(_NearbyDisplayName) _then;

/// Create a copy of NearbyDisplayName
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,}) {
  return _then(_NearbyDisplayName(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
