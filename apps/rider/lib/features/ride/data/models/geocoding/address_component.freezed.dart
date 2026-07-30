// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_component.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddressComponent {

 String? get longText; List<String> get types; String? get languageCode;
/// Create a copy of AddressComponent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressComponentCopyWith<AddressComponent> get copyWith => _$AddressComponentCopyWithImpl<AddressComponent>(this as AddressComponent, _$identity);

  /// Serializes this AddressComponent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressComponent&&(identical(other.longText, longText) || other.longText == longText)&&const DeepCollectionEquality().equals(other.types, types)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,longText,const DeepCollectionEquality().hash(types),languageCode);

@override
String toString() {
  return 'AddressComponent(longText: $longText, types: $types, languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class $AddressComponentCopyWith<$Res>  {
  factory $AddressComponentCopyWith(AddressComponent value, $Res Function(AddressComponent) _then) = _$AddressComponentCopyWithImpl;
@useResult
$Res call({
 String? longText, List<String> types, String? languageCode
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
@pragma('vm:prefer-inline') @override $Res call({Object? longText = freezed,Object? types = null,Object? languageCode = freezed,}) {
  return _then(_self.copyWith(
longText: freezed == longText ? _self.longText : longText // ignore: cast_nullable_to_non_nullable
as String?,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,languageCode: freezed == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? longText,  List<String> types,  String? languageCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddressComponent() when $default != null:
return $default(_that.longText,_that.types,_that.languageCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? longText,  List<String> types,  String? languageCode)  $default,) {final _that = this;
switch (_that) {
case _AddressComponent():
return $default(_that.longText,_that.types,_that.languageCode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? longText,  List<String> types,  String? languageCode)?  $default,) {final _that = this;
switch (_that) {
case _AddressComponent() when $default != null:
return $default(_that.longText,_that.types,_that.languageCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AddressComponent implements AddressComponent {
  const _AddressComponent({this.longText, final  List<String> types = const <String>[], this.languageCode}): _types = types;
  factory _AddressComponent.fromJson(Map<String, dynamic> json) => _$AddressComponentFromJson(json);

@override final  String? longText;
 final  List<String> _types;
@override@JsonKey() List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

@override final  String? languageCode;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddressComponent&&(identical(other.longText, longText) || other.longText == longText)&&const DeepCollectionEquality().equals(other._types, _types)&&(identical(other.languageCode, languageCode) || other.languageCode == languageCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,longText,const DeepCollectionEquality().hash(_types),languageCode);

@override
String toString() {
  return 'AddressComponent(longText: $longText, types: $types, languageCode: $languageCode)';
}


}

/// @nodoc
abstract mixin class _$AddressComponentCopyWith<$Res> implements $AddressComponentCopyWith<$Res> {
  factory _$AddressComponentCopyWith(_AddressComponent value, $Res Function(_AddressComponent) _then) = __$AddressComponentCopyWithImpl;
@override @useResult
$Res call({
 String? longText, List<String> types, String? languageCode
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
@override @pragma('vm:prefer-inline') $Res call({Object? longText = freezed,Object? types = null,Object? languageCode = freezed,}) {
  return _then(_AddressComponent(
longText: freezed == longText ? _self.longText : longText // ignore: cast_nullable_to_non_nullable
as String?,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,languageCode: freezed == languageCode ? _self.languageCode : languageCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
