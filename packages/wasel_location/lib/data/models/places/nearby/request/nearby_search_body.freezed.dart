// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearby_search_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NearbySearchBody {

 String get languageCode; int get maxResultCount; String get rankPreference; NearbyLocationRestriction get locationRestriction;
/// Create a copy of NearbySearchBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbySearchBodyCopyWith<NearbySearchBody> get copyWith => _$NearbySearchBodyCopyWithImpl<NearbySearchBody>(this as NearbySearchBody, _$identity);

  /// Serializes this NearbySearchBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbySearchBody&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.maxResultCount, maxResultCount) || other.maxResultCount == maxResultCount)&&(identical(other.rankPreference, rankPreference) || other.rankPreference == rankPreference)&&(identical(other.locationRestriction, locationRestriction) || other.locationRestriction == locationRestriction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageCode,maxResultCount,rankPreference,locationRestriction);

@override
String toString() {
  return 'NearbySearchBody(languageCode: $languageCode, maxResultCount: $maxResultCount, rankPreference: $rankPreference, locationRestriction: $locationRestriction)';
}


}

/// @nodoc
abstract mixin class $NearbySearchBodyCopyWith<$Res>  {
  factory $NearbySearchBodyCopyWith(NearbySearchBody value, $Res Function(NearbySearchBody) _then) = _$NearbySearchBodyCopyWithImpl;
@useResult
$Res call({
 String languageCode, int maxResultCount, String rankPreference, NearbyLocationRestriction locationRestriction
});


$NearbyLocationRestrictionCopyWith<$Res> get locationRestriction;

}
/// @nodoc
class _$NearbySearchBodyCopyWithImpl<$Res>
    implements $NearbySearchBodyCopyWith<$Res> {
  _$NearbySearchBodyCopyWithImpl(this._self, this._then);

  final NearbySearchBody _self;
  final $Res Function(NearbySearchBody) _then;

/// Create a copy of NearbySearchBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageCode = null,Object? maxResultCount = null,Object? rankPreference = null,Object? locationRestriction = null,}) {
  return _then(_self.copyWith(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,maxResultCount: null == maxResultCount ? _self.maxResultCount : maxResultCount // ignore: cast_nullable_to_non_nullable
as int,rankPreference: null == rankPreference ? _self.rankPreference : rankPreference // ignore: cast_nullable_to_non_nullable
as String,locationRestriction: null == locationRestriction ? _self.locationRestriction : locationRestriction // ignore: cast_nullable_to_non_nullable
as NearbyLocationRestriction,
  ));
}
/// Create a copy of NearbySearchBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NearbyLocationRestrictionCopyWith<$Res> get locationRestriction {
  
  return $NearbyLocationRestrictionCopyWith<$Res>(_self.locationRestriction, (value) {
    return _then(_self.copyWith(locationRestriction: value));
  });
}
}


/// Adds pattern-matching-related methods to [NearbySearchBody].
extension NearbySearchBodyPatterns on NearbySearchBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbySearchBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbySearchBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbySearchBody value)  $default,){
final _that = this;
switch (_that) {
case _NearbySearchBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbySearchBody value)?  $default,){
final _that = this;
switch (_that) {
case _NearbySearchBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String languageCode,  int maxResultCount,  String rankPreference,  NearbyLocationRestriction locationRestriction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbySearchBody() when $default != null:
return $default(_that.languageCode,_that.maxResultCount,_that.rankPreference,_that.locationRestriction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String languageCode,  int maxResultCount,  String rankPreference,  NearbyLocationRestriction locationRestriction)  $default,) {final _that = this;
switch (_that) {
case _NearbySearchBody():
return $default(_that.languageCode,_that.maxResultCount,_that.rankPreference,_that.locationRestriction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String languageCode,  int maxResultCount,  String rankPreference,  NearbyLocationRestriction locationRestriction)?  $default,) {final _that = this;
switch (_that) {
case _NearbySearchBody() when $default != null:
return $default(_that.languageCode,_that.maxResultCount,_that.rankPreference,_that.locationRestriction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbySearchBody implements NearbySearchBody {
  const _NearbySearchBody({required this.languageCode, required this.maxResultCount, required this.rankPreference, required this.locationRestriction});
  factory _NearbySearchBody.fromJson(Map<String, dynamic> json) => _$NearbySearchBodyFromJson(json);

@override final  String languageCode;
@override final  int maxResultCount;
@override final  String rankPreference;
@override final  NearbyLocationRestriction locationRestriction;

/// Create a copy of NearbySearchBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbySearchBodyCopyWith<_NearbySearchBody> get copyWith => __$NearbySearchBodyCopyWithImpl<_NearbySearchBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbySearchBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbySearchBody&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&(identical(other.maxResultCount, maxResultCount) || other.maxResultCount == maxResultCount)&&(identical(other.rankPreference, rankPreference) || other.rankPreference == rankPreference)&&(identical(other.locationRestriction, locationRestriction) || other.locationRestriction == locationRestriction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageCode,maxResultCount,rankPreference,locationRestriction);

@override
String toString() {
  return 'NearbySearchBody(languageCode: $languageCode, maxResultCount: $maxResultCount, rankPreference: $rankPreference, locationRestriction: $locationRestriction)';
}


}

/// @nodoc
abstract mixin class _$NearbySearchBodyCopyWith<$Res> implements $NearbySearchBodyCopyWith<$Res> {
  factory _$NearbySearchBodyCopyWith(_NearbySearchBody value, $Res Function(_NearbySearchBody) _then) = __$NearbySearchBodyCopyWithImpl;
@override @useResult
$Res call({
 String languageCode, int maxResultCount, String rankPreference, NearbyLocationRestriction locationRestriction
});


@override $NearbyLocationRestrictionCopyWith<$Res> get locationRestriction;

}
/// @nodoc
class __$NearbySearchBodyCopyWithImpl<$Res>
    implements _$NearbySearchBodyCopyWith<$Res> {
  __$NearbySearchBodyCopyWithImpl(this._self, this._then);

  final _NearbySearchBody _self;
  final $Res Function(_NearbySearchBody) _then;

/// Create a copy of NearbySearchBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageCode = null,Object? maxResultCount = null,Object? rankPreference = null,Object? locationRestriction = null,}) {
  return _then(_NearbySearchBody(
languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,maxResultCount: null == maxResultCount ? _self.maxResultCount : maxResultCount // ignore: cast_nullable_to_non_nullable
as int,rankPreference: null == rankPreference ? _self.rankPreference : rankPreference // ignore: cast_nullable_to_non_nullable
as String,locationRestriction: null == locationRestriction ? _self.locationRestriction : locationRestriction // ignore: cast_nullable_to_non_nullable
as NearbyLocationRestriction,
  ));
}

/// Create a copy of NearbySearchBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NearbyLocationRestrictionCopyWith<$Res> get locationRestriction {
  
  return $NearbyLocationRestrictionCopyWith<$Res>(_self.locationRestriction, (value) {
    return _then(_self.copyWith(locationRestriction: value));
  });
}
}


/// @nodoc
mixin _$NearbyLocationRestriction {

 AutocompleteCircle get circle;
/// Create a copy of NearbyLocationRestriction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbyLocationRestrictionCopyWith<NearbyLocationRestriction> get copyWith => _$NearbyLocationRestrictionCopyWithImpl<NearbyLocationRestriction>(this as NearbyLocationRestriction, _$identity);

  /// Serializes this NearbyLocationRestriction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbyLocationRestriction&&(identical(other.circle, circle) || other.circle == circle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,circle);

@override
String toString() {
  return 'NearbyLocationRestriction(circle: $circle)';
}


}

/// @nodoc
abstract mixin class $NearbyLocationRestrictionCopyWith<$Res>  {
  factory $NearbyLocationRestrictionCopyWith(NearbyLocationRestriction value, $Res Function(NearbyLocationRestriction) _then) = _$NearbyLocationRestrictionCopyWithImpl;
@useResult
$Res call({
 AutocompleteCircle circle
});


$AutocompleteCircleCopyWith<$Res> get circle;

}
/// @nodoc
class _$NearbyLocationRestrictionCopyWithImpl<$Res>
    implements $NearbyLocationRestrictionCopyWith<$Res> {
  _$NearbyLocationRestrictionCopyWithImpl(this._self, this._then);

  final NearbyLocationRestriction _self;
  final $Res Function(NearbyLocationRestriction) _then;

/// Create a copy of NearbyLocationRestriction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? circle = null,}) {
  return _then(_self.copyWith(
circle: null == circle ? _self.circle : circle // ignore: cast_nullable_to_non_nullable
as AutocompleteCircle,
  ));
}
/// Create a copy of NearbyLocationRestriction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AutocompleteCircleCopyWith<$Res> get circle {
  
  return $AutocompleteCircleCopyWith<$Res>(_self.circle, (value) {
    return _then(_self.copyWith(circle: value));
  });
}
}


/// Adds pattern-matching-related methods to [NearbyLocationRestriction].
extension NearbyLocationRestrictionPatterns on NearbyLocationRestriction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NearbyLocationRestriction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NearbyLocationRestriction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NearbyLocationRestriction value)  $default,){
final _that = this;
switch (_that) {
case _NearbyLocationRestriction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NearbyLocationRestriction value)?  $default,){
final _that = this;
switch (_that) {
case _NearbyLocationRestriction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AutocompleteCircle circle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NearbyLocationRestriction() when $default != null:
return $default(_that.circle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AutocompleteCircle circle)  $default,) {final _that = this;
switch (_that) {
case _NearbyLocationRestriction():
return $default(_that.circle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AutocompleteCircle circle)?  $default,) {final _that = this;
switch (_that) {
case _NearbyLocationRestriction() when $default != null:
return $default(_that.circle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NearbyLocationRestriction implements NearbyLocationRestriction {
  const _NearbyLocationRestriction({required this.circle});
  factory _NearbyLocationRestriction.fromJson(Map<String, dynamic> json) => _$NearbyLocationRestrictionFromJson(json);

@override final  AutocompleteCircle circle;

/// Create a copy of NearbyLocationRestriction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbyLocationRestrictionCopyWith<_NearbyLocationRestriction> get copyWith => __$NearbyLocationRestrictionCopyWithImpl<_NearbyLocationRestriction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbyLocationRestrictionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbyLocationRestriction&&(identical(other.circle, circle) || other.circle == circle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,circle);

@override
String toString() {
  return 'NearbyLocationRestriction(circle: $circle)';
}


}

/// @nodoc
abstract mixin class _$NearbyLocationRestrictionCopyWith<$Res> implements $NearbyLocationRestrictionCopyWith<$Res> {
  factory _$NearbyLocationRestrictionCopyWith(_NearbyLocationRestriction value, $Res Function(_NearbyLocationRestriction) _then) = __$NearbyLocationRestrictionCopyWithImpl;
@override @useResult
$Res call({
 AutocompleteCircle circle
});


@override $AutocompleteCircleCopyWith<$Res> get circle;

}
/// @nodoc
class __$NearbyLocationRestrictionCopyWithImpl<$Res>
    implements _$NearbyLocationRestrictionCopyWith<$Res> {
  __$NearbyLocationRestrictionCopyWithImpl(this._self, this._then);

  final _NearbyLocationRestriction _self;
  final $Res Function(_NearbyLocationRestriction) _then;

/// Create a copy of NearbyLocationRestriction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? circle = null,}) {
  return _then(_NearbyLocationRestriction(
circle: null == circle ? _self.circle : circle // ignore: cast_nullable_to_non_nullable
as AutocompleteCircle,
  ));
}

/// Create a copy of NearbyLocationRestriction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AutocompleteCircleCopyWith<$Res> get circle {
  
  return $AutocompleteCircleCopyWith<$Res>(_self.circle, (value) {
    return _then(_self.copyWith(circle: value));
  });
}
}

// dart format on
