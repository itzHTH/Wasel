// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'autocomplete_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AutocompleteBody {

 String get input; String get sessionToken; String get languageCode; List<String> get includedRegionCodes;@JsonKey(includeIfNull: false) AutocompleteLocationBias? get locationBias;
/// Create a copy of AutocompleteBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutocompleteBodyCopyWith<AutocompleteBody> get copyWith => _$AutocompleteBodyCopyWithImpl<AutocompleteBody>(this as AutocompleteBody, _$identity);

  /// Serializes this AutocompleteBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutocompleteBody&&(identical(other.input, input) || other.input == input)&&(identical(other.sessionToken, sessionToken) || other.sessionToken == sessionToken)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&const DeepCollectionEquality().equals(other.includedRegionCodes, includedRegionCodes)&&(identical(other.locationBias, locationBias) || other.locationBias == locationBias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,input,sessionToken,languageCode,const DeepCollectionEquality().hash(includedRegionCodes),locationBias);

@override
String toString() {
  return 'AutocompleteBody(input: $input, sessionToken: $sessionToken, languageCode: $languageCode, includedRegionCodes: $includedRegionCodes, locationBias: $locationBias)';
}


}

/// @nodoc
abstract mixin class $AutocompleteBodyCopyWith<$Res>  {
  factory $AutocompleteBodyCopyWith(AutocompleteBody value, $Res Function(AutocompleteBody) _then) = _$AutocompleteBodyCopyWithImpl;
@useResult
$Res call({
 String input, String sessionToken, String languageCode, List<String> includedRegionCodes,@JsonKey(includeIfNull: false) AutocompleteLocationBias? locationBias
});


$AutocompleteLocationBiasCopyWith<$Res>? get locationBias;

}
/// @nodoc
class _$AutocompleteBodyCopyWithImpl<$Res>
    implements $AutocompleteBodyCopyWith<$Res> {
  _$AutocompleteBodyCopyWithImpl(this._self, this._then);

  final AutocompleteBody _self;
  final $Res Function(AutocompleteBody) _then;

/// Create a copy of AutocompleteBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? input = null,Object? sessionToken = null,Object? languageCode = null,Object? includedRegionCodes = null,Object? locationBias = freezed,}) {
  return _then(_self.copyWith(
input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,sessionToken: null == sessionToken ? _self.sessionToken : sessionToken // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,includedRegionCodes: null == includedRegionCodes ? _self.includedRegionCodes : includedRegionCodes // ignore: cast_nullable_to_non_nullable
as List<String>,locationBias: freezed == locationBias ? _self.locationBias : locationBias // ignore: cast_nullable_to_non_nullable
as AutocompleteLocationBias?,
  ));
}
/// Create a copy of AutocompleteBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AutocompleteLocationBiasCopyWith<$Res>? get locationBias {
    if (_self.locationBias == null) {
    return null;
  }

  return $AutocompleteLocationBiasCopyWith<$Res>(_self.locationBias!, (value) {
    return _then(_self.copyWith(locationBias: value));
  });
}
}


/// Adds pattern-matching-related methods to [AutocompleteBody].
extension AutocompleteBodyPatterns on AutocompleteBody {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutocompleteBody value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutocompleteBody() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutocompleteBody value)  $default,){
final _that = this;
switch (_that) {
case _AutocompleteBody():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutocompleteBody value)?  $default,){
final _that = this;
switch (_that) {
case _AutocompleteBody() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String input,  String sessionToken,  String languageCode,  List<String> includedRegionCodes, @JsonKey(includeIfNull: false)  AutocompleteLocationBias? locationBias)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutocompleteBody() when $default != null:
return $default(_that.input,_that.sessionToken,_that.languageCode,_that.includedRegionCodes,_that.locationBias);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String input,  String sessionToken,  String languageCode,  List<String> includedRegionCodes, @JsonKey(includeIfNull: false)  AutocompleteLocationBias? locationBias)  $default,) {final _that = this;
switch (_that) {
case _AutocompleteBody():
return $default(_that.input,_that.sessionToken,_that.languageCode,_that.includedRegionCodes,_that.locationBias);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String input,  String sessionToken,  String languageCode,  List<String> includedRegionCodes, @JsonKey(includeIfNull: false)  AutocompleteLocationBias? locationBias)?  $default,) {final _that = this;
switch (_that) {
case _AutocompleteBody() when $default != null:
return $default(_that.input,_that.sessionToken,_that.languageCode,_that.includedRegionCodes,_that.locationBias);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutocompleteBody implements AutocompleteBody {
  const _AutocompleteBody({required this.input, required this.sessionToken, required this.languageCode, required final  List<String> includedRegionCodes, @JsonKey(includeIfNull: false) this.locationBias}): _includedRegionCodes = includedRegionCodes;
  factory _AutocompleteBody.fromJson(Map<String, dynamic> json) => _$AutocompleteBodyFromJson(json);

@override final  String input;
@override final  String sessionToken;
@override final  String languageCode;
 final  List<String> _includedRegionCodes;
@override List<String> get includedRegionCodes {
  if (_includedRegionCodes is EqualUnmodifiableListView) return _includedRegionCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_includedRegionCodes);
}

@override@JsonKey(includeIfNull: false) final  AutocompleteLocationBias? locationBias;

/// Create a copy of AutocompleteBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutocompleteBodyCopyWith<_AutocompleteBody> get copyWith => __$AutocompleteBodyCopyWithImpl<_AutocompleteBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutocompleteBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutocompleteBody&&(identical(other.input, input) || other.input == input)&&(identical(other.sessionToken, sessionToken) || other.sessionToken == sessionToken)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode)&&const DeepCollectionEquality().equals(other._includedRegionCodes, _includedRegionCodes)&&(identical(other.locationBias, locationBias) || other.locationBias == locationBias));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,input,sessionToken,languageCode,const DeepCollectionEquality().hash(_includedRegionCodes),locationBias);

@override
String toString() {
  return 'AutocompleteBody(input: $input, sessionToken: $sessionToken, languageCode: $languageCode, includedRegionCodes: $includedRegionCodes, locationBias: $locationBias)';
}


}

/// @nodoc
abstract mixin class _$AutocompleteBodyCopyWith<$Res> implements $AutocompleteBodyCopyWith<$Res> {
  factory _$AutocompleteBodyCopyWith(_AutocompleteBody value, $Res Function(_AutocompleteBody) _then) = __$AutocompleteBodyCopyWithImpl;
@override @useResult
$Res call({
 String input, String sessionToken, String languageCode, List<String> includedRegionCodes,@JsonKey(includeIfNull: false) AutocompleteLocationBias? locationBias
});


@override $AutocompleteLocationBiasCopyWith<$Res>? get locationBias;

}
/// @nodoc
class __$AutocompleteBodyCopyWithImpl<$Res>
    implements _$AutocompleteBodyCopyWith<$Res> {
  __$AutocompleteBodyCopyWithImpl(this._self, this._then);

  final _AutocompleteBody _self;
  final $Res Function(_AutocompleteBody) _then;

/// Create a copy of AutocompleteBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? input = null,Object? sessionToken = null,Object? languageCode = null,Object? includedRegionCodes = null,Object? locationBias = freezed,}) {
  return _then(_AutocompleteBody(
input: null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String,sessionToken: null == sessionToken ? _self.sessionToken : sessionToken // ignore: cast_nullable_to_non_nullable
as String,languageCode: null == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String,includedRegionCodes: null == includedRegionCodes ? _self._includedRegionCodes : includedRegionCodes // ignore: cast_nullable_to_non_nullable
as List<String>,locationBias: freezed == locationBias ? _self.locationBias : locationBias // ignore: cast_nullable_to_non_nullable
as AutocompleteLocationBias?,
  ));
}

/// Create a copy of AutocompleteBody
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AutocompleteLocationBiasCopyWith<$Res>? get locationBias {
    if (_self.locationBias == null) {
    return null;
  }

  return $AutocompleteLocationBiasCopyWith<$Res>(_self.locationBias!, (value) {
    return _then(_self.copyWith(locationBias: value));
  });
}
}


/// @nodoc
mixin _$AutocompleteLocationBias {

 AutocompleteCircle get circle;
/// Create a copy of AutocompleteLocationBias
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutocompleteLocationBiasCopyWith<AutocompleteLocationBias> get copyWith => _$AutocompleteLocationBiasCopyWithImpl<AutocompleteLocationBias>(this as AutocompleteLocationBias, _$identity);

  /// Serializes this AutocompleteLocationBias to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutocompleteLocationBias&&(identical(other.circle, circle) || other.circle == circle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,circle);

@override
String toString() {
  return 'AutocompleteLocationBias(circle: $circle)';
}


}

/// @nodoc
abstract mixin class $AutocompleteLocationBiasCopyWith<$Res>  {
  factory $AutocompleteLocationBiasCopyWith(AutocompleteLocationBias value, $Res Function(AutocompleteLocationBias) _then) = _$AutocompleteLocationBiasCopyWithImpl;
@useResult
$Res call({
 AutocompleteCircle circle
});


$AutocompleteCircleCopyWith<$Res> get circle;

}
/// @nodoc
class _$AutocompleteLocationBiasCopyWithImpl<$Res>
    implements $AutocompleteLocationBiasCopyWith<$Res> {
  _$AutocompleteLocationBiasCopyWithImpl(this._self, this._then);

  final AutocompleteLocationBias _self;
  final $Res Function(AutocompleteLocationBias) _then;

/// Create a copy of AutocompleteLocationBias
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? circle = null,}) {
  return _then(_self.copyWith(
circle: null == circle ? _self.circle : circle // ignore: cast_nullable_to_non_nullable
as AutocompleteCircle,
  ));
}
/// Create a copy of AutocompleteLocationBias
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AutocompleteCircleCopyWith<$Res> get circle {
  
  return $AutocompleteCircleCopyWith<$Res>(_self.circle, (value) {
    return _then(_self.copyWith(circle: value));
  });
}
}


/// Adds pattern-matching-related methods to [AutocompleteLocationBias].
extension AutocompleteLocationBiasPatterns on AutocompleteLocationBias {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutocompleteLocationBias value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutocompleteLocationBias() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutocompleteLocationBias value)  $default,){
final _that = this;
switch (_that) {
case _AutocompleteLocationBias():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutocompleteLocationBias value)?  $default,){
final _that = this;
switch (_that) {
case _AutocompleteLocationBias() when $default != null:
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
case _AutocompleteLocationBias() when $default != null:
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
case _AutocompleteLocationBias():
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
case _AutocompleteLocationBias() when $default != null:
return $default(_that.circle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutocompleteLocationBias implements AutocompleteLocationBias {
  const _AutocompleteLocationBias({required this.circle});
  factory _AutocompleteLocationBias.fromJson(Map<String, dynamic> json) => _$AutocompleteLocationBiasFromJson(json);

@override final  AutocompleteCircle circle;

/// Create a copy of AutocompleteLocationBias
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutocompleteLocationBiasCopyWith<_AutocompleteLocationBias> get copyWith => __$AutocompleteLocationBiasCopyWithImpl<_AutocompleteLocationBias>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutocompleteLocationBiasToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutocompleteLocationBias&&(identical(other.circle, circle) || other.circle == circle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,circle);

@override
String toString() {
  return 'AutocompleteLocationBias(circle: $circle)';
}


}

/// @nodoc
abstract mixin class _$AutocompleteLocationBiasCopyWith<$Res> implements $AutocompleteLocationBiasCopyWith<$Res> {
  factory _$AutocompleteLocationBiasCopyWith(_AutocompleteLocationBias value, $Res Function(_AutocompleteLocationBias) _then) = __$AutocompleteLocationBiasCopyWithImpl;
@override @useResult
$Res call({
 AutocompleteCircle circle
});


@override $AutocompleteCircleCopyWith<$Res> get circle;

}
/// @nodoc
class __$AutocompleteLocationBiasCopyWithImpl<$Res>
    implements _$AutocompleteLocationBiasCopyWith<$Res> {
  __$AutocompleteLocationBiasCopyWithImpl(this._self, this._then);

  final _AutocompleteLocationBias _self;
  final $Res Function(_AutocompleteLocationBias) _then;

/// Create a copy of AutocompleteLocationBias
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? circle = null,}) {
  return _then(_AutocompleteLocationBias(
circle: null == circle ? _self.circle : circle // ignore: cast_nullable_to_non_nullable
as AutocompleteCircle,
  ));
}

/// Create a copy of AutocompleteLocationBias
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AutocompleteCircleCopyWith<$Res> get circle {
  
  return $AutocompleteCircleCopyWith<$Res>(_self.circle, (value) {
    return _then(_self.copyWith(circle: value));
  });
}
}


/// @nodoc
mixin _$AutocompleteCircle {

 GoogleLatLng get center; double get radius;
/// Create a copy of AutocompleteCircle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutocompleteCircleCopyWith<AutocompleteCircle> get copyWith => _$AutocompleteCircleCopyWithImpl<AutocompleteCircle>(this as AutocompleteCircle, _$identity);

  /// Serializes this AutocompleteCircle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutocompleteCircle&&(identical(other.center, center) || other.center == center)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,center,radius);

@override
String toString() {
  return 'AutocompleteCircle(center: $center, radius: $radius)';
}


}

/// @nodoc
abstract mixin class $AutocompleteCircleCopyWith<$Res>  {
  factory $AutocompleteCircleCopyWith(AutocompleteCircle value, $Res Function(AutocompleteCircle) _then) = _$AutocompleteCircleCopyWithImpl;
@useResult
$Res call({
 GoogleLatLng center, double radius
});


$GoogleLatLngCopyWith<$Res> get center;

}
/// @nodoc
class _$AutocompleteCircleCopyWithImpl<$Res>
    implements $AutocompleteCircleCopyWith<$Res> {
  _$AutocompleteCircleCopyWithImpl(this._self, this._then);

  final AutocompleteCircle _self;
  final $Res Function(AutocompleteCircle) _then;

/// Create a copy of AutocompleteCircle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? center = null,Object? radius = null,}) {
  return _then(_self.copyWith(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as GoogleLatLng,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of AutocompleteCircle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoogleLatLngCopyWith<$Res> get center {
  
  return $GoogleLatLngCopyWith<$Res>(_self.center, (value) {
    return _then(_self.copyWith(center: value));
  });
}
}


/// Adds pattern-matching-related methods to [AutocompleteCircle].
extension AutocompleteCirclePatterns on AutocompleteCircle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutocompleteCircle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutocompleteCircle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutocompleteCircle value)  $default,){
final _that = this;
switch (_that) {
case _AutocompleteCircle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutocompleteCircle value)?  $default,){
final _that = this;
switch (_that) {
case _AutocompleteCircle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GoogleLatLng center,  double radius)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutocompleteCircle() when $default != null:
return $default(_that.center,_that.radius);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GoogleLatLng center,  double radius)  $default,) {final _that = this;
switch (_that) {
case _AutocompleteCircle():
return $default(_that.center,_that.radius);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GoogleLatLng center,  double radius)?  $default,) {final _that = this;
switch (_that) {
case _AutocompleteCircle() when $default != null:
return $default(_that.center,_that.radius);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutocompleteCircle implements AutocompleteCircle {
  const _AutocompleteCircle({required this.center, required this.radius});
  factory _AutocompleteCircle.fromJson(Map<String, dynamic> json) => _$AutocompleteCircleFromJson(json);

@override final  GoogleLatLng center;
@override final  double radius;

/// Create a copy of AutocompleteCircle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutocompleteCircleCopyWith<_AutocompleteCircle> get copyWith => __$AutocompleteCircleCopyWithImpl<_AutocompleteCircle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutocompleteCircleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutocompleteCircle&&(identical(other.center, center) || other.center == center)&&(identical(other.radius, radius) || other.radius == radius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,center,radius);

@override
String toString() {
  return 'AutocompleteCircle(center: $center, radius: $radius)';
}


}

/// @nodoc
abstract mixin class _$AutocompleteCircleCopyWith<$Res> implements $AutocompleteCircleCopyWith<$Res> {
  factory _$AutocompleteCircleCopyWith(_AutocompleteCircle value, $Res Function(_AutocompleteCircle) _then) = __$AutocompleteCircleCopyWithImpl;
@override @useResult
$Res call({
 GoogleLatLng center, double radius
});


@override $GoogleLatLngCopyWith<$Res> get center;

}
/// @nodoc
class __$AutocompleteCircleCopyWithImpl<$Res>
    implements _$AutocompleteCircleCopyWith<$Res> {
  __$AutocompleteCircleCopyWithImpl(this._self, this._then);

  final _AutocompleteCircle _self;
  final $Res Function(_AutocompleteCircle) _then;

/// Create a copy of AutocompleteCircle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? center = null,Object? radius = null,}) {
  return _then(_AutocompleteCircle(
center: null == center ? _self.center : center // ignore: cast_nullable_to_non_nullable
as GoogleLatLng,radius: null == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of AutocompleteCircle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoogleLatLngCopyWith<$Res> get center {
  
  return $GoogleLatLngCopyWith<$Res>(_self.center, (value) {
    return _then(_self.copyWith(center: value));
  });
}
}


/// @nodoc
mixin _$GoogleLatLng {

 double get latitude; double get longitude;
/// Create a copy of GoogleLatLng
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoogleLatLngCopyWith<GoogleLatLng> get copyWith => _$GoogleLatLngCopyWithImpl<GoogleLatLng>(this as GoogleLatLng, _$identity);

  /// Serializes this GoogleLatLng to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleLatLng&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'GoogleLatLng(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class $GoogleLatLngCopyWith<$Res>  {
  factory $GoogleLatLngCopyWith(GoogleLatLng value, $Res Function(GoogleLatLng) _then) = _$GoogleLatLngCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class _$GoogleLatLngCopyWithImpl<$Res>
    implements $GoogleLatLngCopyWith<$Res> {
  _$GoogleLatLngCopyWithImpl(this._self, this._then);

  final GoogleLatLng _self;
  final $Res Function(GoogleLatLng) _then;

/// Create a copy of GoogleLatLng
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [GoogleLatLng].
extension GoogleLatLngPatterns on GoogleLatLng {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoogleLatLng value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoogleLatLng() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoogleLatLng value)  $default,){
final _that = this;
switch (_that) {
case _GoogleLatLng():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoogleLatLng value)?  $default,){
final _that = this;
switch (_that) {
case _GoogleLatLng() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double latitude,  double longitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoogleLatLng() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double latitude,  double longitude)  $default,) {final _that = this;
switch (_that) {
case _GoogleLatLng():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double latitude,  double longitude)?  $default,) {final _that = this;
switch (_that) {
case _GoogleLatLng() when $default != null:
return $default(_that.latitude,_that.longitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GoogleLatLng implements GoogleLatLng {
  const _GoogleLatLng({required this.latitude, required this.longitude});
  factory _GoogleLatLng.fromJson(Map<String, dynamic> json) => _$GoogleLatLngFromJson(json);

@override final  double latitude;
@override final  double longitude;

/// Create a copy of GoogleLatLng
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoogleLatLngCopyWith<_GoogleLatLng> get copyWith => __$GoogleLatLngCopyWithImpl<_GoogleLatLng>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoogleLatLngToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoogleLatLng&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude);

@override
String toString() {
  return 'GoogleLatLng(latitude: $latitude, longitude: $longitude)';
}


}

/// @nodoc
abstract mixin class _$GoogleLatLngCopyWith<$Res> implements $GoogleLatLngCopyWith<$Res> {
  factory _$GoogleLatLngCopyWith(_GoogleLatLng value, $Res Function(_GoogleLatLng) _then) = __$GoogleLatLngCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude
});




}
/// @nodoc
class __$GoogleLatLngCopyWithImpl<$Res>
    implements _$GoogleLatLngCopyWith<$Res> {
  __$GoogleLatLngCopyWithImpl(this._self, this._then);

  final _GoogleLatLng _self;
  final $Res Function(_GoogleLatLng) _then;

/// Create a copy of GoogleLatLng
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,}) {
  return _then(_GoogleLatLng(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
