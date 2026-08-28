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

 RideStage get stage; DriverProfile? get driver; GeoPoint? get driverPosition;/// The last snapshot the backend gave us, which is the source of truth for
/// everything the ride UI draws.
 ActiveRide? get ride;/// The ride being tracked, known as soon as the server accepts the request.
/// [ride] only turns up once the backend has described the whole trip, so
/// this is what a freshly requested ride is driven by until then.
 String? get trackedRideId;/// The opening `GET /Rides/active` is still in flight, so we do not yet
/// know whether there is a ride to show.
 bool get isRecovering;/// The read failed and there was no ride on screen to fall back on, so we
/// still do not know what the rider has. Kept apart from [error], which
/// describes something that happened to a ride we do know about.
 String? get recoveryError;/// The driver's socket dropped. Purely an overlay: the ride keeps running
/// and its stage is untouched.
 bool get isDriverDisconnected; bool get isLoading; String? get error;
/// Create a copy of RideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideStateCopyWith<RideState> get copyWith => _$RideStateCopyWithImpl<RideState>(this as RideState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RideState'))
    ..add(DiagnosticsProperty('stage', stage))..add(DiagnosticsProperty('driver', driver))..add(DiagnosticsProperty('driverPosition', driverPosition))..add(DiagnosticsProperty('ride', ride))..add(DiagnosticsProperty('trackedRideId', trackedRideId))..add(DiagnosticsProperty('isRecovering', isRecovering))..add(DiagnosticsProperty('recoveryError', recoveryError))..add(DiagnosticsProperty('isDriverDisconnected', isDriverDisconnected))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.driverPosition, driverPosition) || other.driverPosition == driverPosition)&&(identical(other.ride, ride) || other.ride == ride)&&(identical(other.trackedRideId, trackedRideId) || other.trackedRideId == trackedRideId)&&(identical(other.isRecovering, isRecovering) || other.isRecovering == isRecovering)&&(identical(other.recoveryError, recoveryError) || other.recoveryError == recoveryError)&&(identical(other.isDriverDisconnected, isDriverDisconnected) || other.isDriverDisconnected == isDriverDisconnected)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,stage,driver,driverPosition,ride,trackedRideId,isRecovering,recoveryError,isDriverDisconnected,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RideState(stage: $stage, driver: $driver, driverPosition: $driverPosition, ride: $ride, trackedRideId: $trackedRideId, isRecovering: $isRecovering, recoveryError: $recoveryError, isDriverDisconnected: $isDriverDisconnected, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class $RideStateCopyWith<$Res>  {
  factory $RideStateCopyWith(RideState value, $Res Function(RideState) _then) = _$RideStateCopyWithImpl;
@useResult
$Res call({
 RideStage stage, DriverProfile? driver, GeoPoint? driverPosition, ActiveRide? ride, String? trackedRideId, bool isRecovering, String? recoveryError, bool isDriverDisconnected, bool isLoading, String? error
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
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? driver = freezed,Object? driverPosition = freezed,Object? ride = freezed,Object? trackedRideId = freezed,Object? isRecovering = null,Object? recoveryError = freezed,Object? isDriverDisconnected = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as RideStage,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as DriverProfile?,driverPosition: freezed == driverPosition ? _self.driverPosition : driverPosition // ignore: cast_nullable_to_non_nullable
as GeoPoint?,ride: freezed == ride ? _self.ride : ride // ignore: cast_nullable_to_non_nullable
as ActiveRide?,trackedRideId: freezed == trackedRideId ? _self.trackedRideId : trackedRideId // ignore: cast_nullable_to_non_nullable
as String?,isRecovering: null == isRecovering ? _self.isRecovering : isRecovering // ignore: cast_nullable_to_non_nullable
as bool,recoveryError: freezed == recoveryError ? _self.recoveryError : recoveryError // ignore: cast_nullable_to_non_nullable
as String?,isDriverDisconnected: null == isDriverDisconnected ? _self.isDriverDisconnected : isDriverDisconnected // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RideStage stage,  DriverProfile? driver,  GeoPoint? driverPosition,  ActiveRide? ride,  String? trackedRideId,  bool isRecovering,  String? recoveryError,  bool isDriverDisconnected,  bool isLoading,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RideState() when $default != null:
return $default(_that.stage,_that.driver,_that.driverPosition,_that.ride,_that.trackedRideId,_that.isRecovering,_that.recoveryError,_that.isDriverDisconnected,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RideStage stage,  DriverProfile? driver,  GeoPoint? driverPosition,  ActiveRide? ride,  String? trackedRideId,  bool isRecovering,  String? recoveryError,  bool isDriverDisconnected,  bool isLoading,  String? error)  $default,) {final _that = this;
switch (_that) {
case _RideState():
return $default(_that.stage,_that.driver,_that.driverPosition,_that.ride,_that.trackedRideId,_that.isRecovering,_that.recoveryError,_that.isDriverDisconnected,_that.isLoading,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RideStage stage,  DriverProfile? driver,  GeoPoint? driverPosition,  ActiveRide? ride,  String? trackedRideId,  bool isRecovering,  String? recoveryError,  bool isDriverDisconnected,  bool isLoading,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _RideState() when $default != null:
return $default(_that.stage,_that.driver,_that.driverPosition,_that.ride,_that.trackedRideId,_that.isRecovering,_that.recoveryError,_that.isDriverDisconnected,_that.isLoading,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _RideState extends RideState with DiagnosticableTreeMixin {
  const _RideState({this.stage = RideStage.idel, this.driver, this.driverPosition, this.ride, this.trackedRideId, this.isRecovering = false, this.recoveryError, this.isDriverDisconnected = false, this.isLoading = false, this.error}): super._();
  

@override@JsonKey() final  RideStage stage;
@override final  DriverProfile? driver;
@override final  GeoPoint? driverPosition;
/// The last snapshot the backend gave us, which is the source of truth for
/// everything the ride UI draws.
@override final  ActiveRide? ride;
/// The ride being tracked, known as soon as the server accepts the request.
/// [ride] only turns up once the backend has described the whole trip, so
/// this is what a freshly requested ride is driven by until then.
@override final  String? trackedRideId;
/// The opening `GET /Rides/active` is still in flight, so we do not yet
/// know whether there is a ride to show.
@override@JsonKey() final  bool isRecovering;
/// The read failed and there was no ride on screen to fall back on, so we
/// still do not know what the rider has. Kept apart from [error], which
/// describes something that happened to a ride we do know about.
@override final  String? recoveryError;
/// The driver's socket dropped. Purely an overlay: the ride keeps running
/// and its stage is untouched.
@override@JsonKey() final  bool isDriverDisconnected;
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
    ..add(DiagnosticsProperty('stage', stage))..add(DiagnosticsProperty('driver', driver))..add(DiagnosticsProperty('driverPosition', driverPosition))..add(DiagnosticsProperty('ride', ride))..add(DiagnosticsProperty('trackedRideId', trackedRideId))..add(DiagnosticsProperty('isRecovering', isRecovering))..add(DiagnosticsProperty('recoveryError', recoveryError))..add(DiagnosticsProperty('isDriverDisconnected', isDriverDisconnected))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('error', error));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RideState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.driver, driver) || other.driver == driver)&&(identical(other.driverPosition, driverPosition) || other.driverPosition == driverPosition)&&(identical(other.ride, ride) || other.ride == ride)&&(identical(other.trackedRideId, trackedRideId) || other.trackedRideId == trackedRideId)&&(identical(other.isRecovering, isRecovering) || other.isRecovering == isRecovering)&&(identical(other.recoveryError, recoveryError) || other.recoveryError == recoveryError)&&(identical(other.isDriverDisconnected, isDriverDisconnected) || other.isDriverDisconnected == isDriverDisconnected)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,stage,driver,driverPosition,ride,trackedRideId,isRecovering,recoveryError,isDriverDisconnected,isLoading,error);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RideState(stage: $stage, driver: $driver, driverPosition: $driverPosition, ride: $ride, trackedRideId: $trackedRideId, isRecovering: $isRecovering, recoveryError: $recoveryError, isDriverDisconnected: $isDriverDisconnected, isLoading: $isLoading, error: $error)';
}


}

/// @nodoc
abstract mixin class _$RideStateCopyWith<$Res> implements $RideStateCopyWith<$Res> {
  factory _$RideStateCopyWith(_RideState value, $Res Function(_RideState) _then) = __$RideStateCopyWithImpl;
@override @useResult
$Res call({
 RideStage stage, DriverProfile? driver, GeoPoint? driverPosition, ActiveRide? ride, String? trackedRideId, bool isRecovering, String? recoveryError, bool isDriverDisconnected, bool isLoading, String? error
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
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? driver = freezed,Object? driverPosition = freezed,Object? ride = freezed,Object? trackedRideId = freezed,Object? isRecovering = null,Object? recoveryError = freezed,Object? isDriverDisconnected = null,Object? isLoading = null,Object? error = freezed,}) {
  return _then(_RideState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as RideStage,driver: freezed == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as DriverProfile?,driverPosition: freezed == driverPosition ? _self.driverPosition : driverPosition // ignore: cast_nullable_to_non_nullable
as GeoPoint?,ride: freezed == ride ? _self.ride : ride // ignore: cast_nullable_to_non_nullable
as ActiveRide?,trackedRideId: freezed == trackedRideId ? _self.trackedRideId : trackedRideId // ignore: cast_nullable_to_non_nullable
as String?,isRecovering: null == isRecovering ? _self.isRecovering : isRecovering // ignore: cast_nullable_to_non_nullable
as bool,recoveryError: freezed == recoveryError ? _self.recoveryError : recoveryError // ignore: cast_nullable_to_non_nullable
as String?,isDriverDisconnected: null == isDriverDisconnected ? _self.isDriverDisconnected : isDriverDisconnected // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
