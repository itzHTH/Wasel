// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RideState implements DiagnosticableTreeMixin {

 RideStage get stage; DriverProfile? get driver; GeoPoint? get driverPosition; bool get isLoading; String? get error;
/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideStateCopyWith<RideState> get copyWith => _$RideStateCopyWithImpl<RideState>(this as RideState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RideState'))
    ..add(DiagnosticsProperty('stage', stage))..add(DiagnosticsProperty('driver', driver))..add(DiagnosticsProperty('driverPosition', driverPosition))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.driverPosition, driverPosition) || other.driverPosition == driverPosition)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,stage,driver,driverPosition,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RideState(stage: $stage, driver: $driver, driverPosition: $driverPosition, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $RideStateCopyWith<$Res>  {
  factory $RideStateCopyWith(RideState value, $Res Function(RideState) _then) = _$RideStateCopyWithImpl;
@useResult
$Res call({
 RideStage stage, DriverProfile? driver, GeoPoint? driverPosition, bool isLoading, String? error
});




}
/// @nodoc
class _$RideStateCopyWithImpl<$Res>
    implements $RideStateCopyWith<$Res> {
  _$RideStateCopyWithImpl(this._self, this._then);

  final RideState _self;
  final $Res Function(RideState) _then;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? driver = freezed,Object? driverPosition = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as RideStage,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as DriverProfile?,driverPosition: freezed == driverPosition ? _self.driverPosition : driverPosition // ignore: cast_nullable_to_non_nullable
as GeoPoint?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RideState].
extension RideStatePatterns on RideState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RideState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RideState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RideState value)  $default,){
final _that = this;
switch (_that) {
case _RideState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RideState value)?  $default,){
final _that = this;
switch (_that) {
case _RideState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RideStage stage,  DriverProfile? driver,  GeoPoint? driverPosition,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RideState() when $default != null:
return $default(_that.stage,_that.driver,_that.driverPosition,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RideStage stage,  DriverProfile? driver,  GeoPoint? driverPosition,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _RideState():
return $default(_that.stage,_that.driver,_that.driverPosition,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RideStage stage,  DriverProfile? driver,  GeoPoint? driverPosition,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _RideState() when $default != null:
return $default(_that.stage,_that.driver,_that.driverPosition,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _RideState with DiagnosticableTreeMixin implements RideState {
  const _RideState({this.stage = RideStage.idel, this.driver, this.driverPosition, this.isLoading = false, this.error});
  

@override@JsonKey() final  RideStage stage;
@override final  DriverProfile? driver;
@override final  GeoPoint? driverPosition;
@override@JsonKey() final  bool isLoading;
@override final  String? error;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideStateCopyWith<_RideState> get copyWith => __$RideStateCopyWithImpl<_RideState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RideState'))
    ..add(DiagnosticsProperty('stage', stage))..add(DiagnosticsProperty('driver', driver))..add(DiagnosticsProperty('driverPosition', driverPosition))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RideState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.driverPosition, driverPosition) || other.driverPosition == driverPosition)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,stage,driver,driverPosition,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RideState(stage: $stage, driver: $driver, driverPosition: $driverPosition, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$RideStateCopyWith<$Res> implements $RideStateCopyWith<$Res> {
  factory _$RideStateCopyWith(_RideState value, $Res Function(_RideState) _then) = __$RideStateCopyWithImpl;
@override @useResult
$Res call({
 RideStage stage, DriverProfile? driver, GeoPoint? driverPosition, bool isLoading, String? error
});




}
/// @nodoc
class __$RideStateCopyWithImpl<$Res>
    implements _$RideStateCopyWith<$Res> {
  __$RideStateCopyWithImpl(this._self, this._then);

  final _RideState _self;
  final $Res Function(_RideState) _then;

/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? driver = freezed,Object? driverPosition = freezed,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_RideState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as RideStage,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as DriverProfile?,driverPosition: freezed == driverPosition ? _self.driverPosition : driverPosition // ignore: cast_nullable_to_non_nullable
as GeoPoint?,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
