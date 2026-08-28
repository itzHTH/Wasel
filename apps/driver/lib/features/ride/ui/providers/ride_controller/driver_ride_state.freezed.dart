// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_ride_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DriverRideState {

 DriverStage get stage; DriverConnectionState get connection; ReceiveRideRequest? get ride; int get secondsLeft;/// The last snapshot the backend gave us for the ride in hand. This is what
/// a ride recovered after a restart is rebuilt from — the offer that
/// created [ride] only exists in the session that received it.
 ActiveRide? get activeRide;/// The opening `GET /Rides/active` is still in flight, so we do not yet
/// know whether this driver is mid-trip.
 bool get isRecovering;
/// Create a copy of DriverRideState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverRideStateCopyWith<DriverRideState> get copyWith => _$DriverRideStateCopyWithImpl<DriverRideState>(this as DriverRideState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverRideState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.connection, connection) || other.connection == connection)&&const DeepCollectionEquality().equals(other.ride, ride)&&(identical(other.secondsLeft, secondsLeft) || other.secondsLeft == secondsLeft)&&(identical(other.activeRide, activeRide) || other.activeRide == activeRide)&&(identical(other.isRecovering, isRecovering) || other.isRecovering == isRecovering));
}


@override
int get hashCode => Object.hash(runtimeType,stage,connection,const DeepCollectionEquality().hash(ride),secondsLeft,activeRide,isRecovering);

@override
String toString() {
  return 'DriverRideState(stage: $stage, connection: $connection, ride: $ride, secondsLeft: $secondsLeft, activeRide: $activeRide, isRecovering: $isRecovering)';
}


}

/// @nodoc
abstract mixin class $DriverRideStateCopyWith<$Res>  {
  factory $DriverRideStateCopyWith(DriverRideState value, $Res Function(DriverRideState) _then) = _$DriverRideStateCopyWithImpl;
@useResult
$Res call({
 DriverStage stage, DriverConnectionState connection, ReceiveRideRequest? ride, int secondsLeft, ActiveRide? activeRide, bool isRecovering
});




}
/// @nodoc
class _$DriverRideStateCopyWithImpl<$Res>
    implements $DriverRideStateCopyWith<$Res> {
  _$DriverRideStateCopyWithImpl(this._self, this._then);

  final DriverRideState _self;
  final $Res Function(DriverRideState) _then;

/// Create a copy of DriverRideState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? connection = null,Object? ride = freezed,Object? secondsLeft = null,Object? activeRide = freezed,Object? isRecovering = null,}) {
  return _then(_self.copyWith(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as DriverStage,connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as DriverConnectionState,ride: freezed == ride ? _self.ride : ride // ignore: cast_nullable_to_non_nullable
as ReceiveRideRequest?,secondsLeft: null == secondsLeft ? _self.secondsLeft : secondsLeft // ignore: cast_nullable_to_non_nullable
as int,activeRide: freezed == activeRide ? _self.activeRide : activeRide // ignore: cast_nullable_to_non_nullable
as ActiveRide?,isRecovering: null == isRecovering ? _self.isRecovering : isRecovering // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DriverRideState].
extension DriverRideStatePatterns on DriverRideState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DriverRideState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DriverRideState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DriverRideState value)  $default,){
final _that = this;
switch (_that) {
case _DriverRideState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DriverRideState value)?  $default,){
final _that = this;
switch (_that) {
case _DriverRideState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DriverStage stage,  DriverConnectionState connection,  ReceiveRideRequest? ride,  int secondsLeft,  ActiveRide? activeRide,  bool isRecovering)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DriverRideState() when $default != null:
return $default(_that.stage,_that.connection,_that.ride,_that.secondsLeft,_that.activeRide,_that.isRecovering);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DriverStage stage,  DriverConnectionState connection,  ReceiveRideRequest? ride,  int secondsLeft,  ActiveRide? activeRide,  bool isRecovering)  $default,) {final _that = this;
switch (_that) {
case _DriverRideState():
return $default(_that.stage,_that.connection,_that.ride,_that.secondsLeft,_that.activeRide,_that.isRecovering);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DriverStage stage,  DriverConnectionState connection,  ReceiveRideRequest? ride,  int secondsLeft,  ActiveRide? activeRide,  bool isRecovering)?  $default,) {final _that = this;
switch (_that) {
case _DriverRideState() when $default != null:
return $default(_that.stage,_that.connection,_that.ride,_that.secondsLeft,_that.activeRide,_that.isRecovering);case _:
  return null;

}
}

}

/// @nodoc


class _DriverRideState extends DriverRideState {
  const _DriverRideState({this.stage = DriverStage.offline, this.connection = DriverConnectionState.idle, this.ride, this.secondsLeft = 0, this.activeRide, this.isRecovering = false}): super._();
  

@override@JsonKey() final  DriverStage stage;
@override@JsonKey() final  DriverConnectionState connection;
@override final  ReceiveRideRequest? ride;
@override@JsonKey() final  int secondsLeft;
/// The last snapshot the backend gave us for the ride in hand. This is what
/// a ride recovered after a restart is rebuilt from — the offer that
/// created [ride] only exists in the session that received it.
@override final  ActiveRide? activeRide;
/// The opening `GET /Rides/active` is still in flight, so we do not yet
/// know whether this driver is mid-trip.
@override@JsonKey() final  bool isRecovering;

/// Create a copy of DriverRideState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DriverRideStateCopyWith<_DriverRideState> get copyWith => __$DriverRideStateCopyWithImpl<_DriverRideState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DriverRideState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.connection, connection) || other.connection == connection)&&const DeepCollectionEquality().equals(other.ride, ride)&&(identical(other.secondsLeft, secondsLeft) || other.secondsLeft == secondsLeft)&&(identical(other.activeRide, activeRide) || other.activeRide == activeRide)&&(identical(other.isRecovering, isRecovering) || other.isRecovering == isRecovering));
}


@override
int get hashCode => Object.hash(runtimeType,stage,connection,const DeepCollectionEquality().hash(ride),secondsLeft,activeRide,isRecovering);

@override
String toString() {
  return 'DriverRideState(stage: $stage, connection: $connection, ride: $ride, secondsLeft: $secondsLeft, activeRide: $activeRide, isRecovering: $isRecovering)';
}


}

/// @nodoc
abstract mixin class _$DriverRideStateCopyWith<$Res> implements $DriverRideStateCopyWith<$Res> {
  factory _$DriverRideStateCopyWith(_DriverRideState value, $Res Function(_DriverRideState) _then) = __$DriverRideStateCopyWithImpl;
@override @useResult
$Res call({
 DriverStage stage, DriverConnectionState connection, ReceiveRideRequest? ride, int secondsLeft, ActiveRide? activeRide, bool isRecovering
});




}
/// @nodoc
class __$DriverRideStateCopyWithImpl<$Res>
    implements _$DriverRideStateCopyWith<$Res> {
  __$DriverRideStateCopyWithImpl(this._self, this._then);

  final _DriverRideState _self;
  final $Res Function(_DriverRideState) _then;

/// Create a copy of DriverRideState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? connection = null,Object? ride = freezed,Object? secondsLeft = null,Object? activeRide = freezed,Object? isRecovering = null,}) {
  return _then(_DriverRideState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as DriverStage,connection: null == connection ? _self.connection : connection // ignore: cast_nullable_to_non_nullable
as DriverConnectionState,ride: freezed == ride ? _self.ride : ride // ignore: cast_nullable_to_non_nullable
as ReceiveRideRequest?,secondsLeft: null == secondsLeft ? _self.secondsLeft : secondsLeft // ignore: cast_nullable_to_non_nullable
as int,activeRide: freezed == activeRide ? _self.activeRide : activeRide // ignore: cast_nullable_to_non_nullable
as ActiveRide?,isRecovering: null == isRecovering ? _self.isRecovering : isRecovering // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
