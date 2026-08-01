// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RideEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RideEvent()';
}


}

/// @nodoc
class $RideEventCopyWith<$Res>  {
$RideEventCopyWith(RideEvent _, $Res Function(RideEvent) __);
}


/// Adds pattern-matching-related methods to [RideEvent].
extension RideEventPatterns on RideEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RideAccepted value)?  accepted,TResult Function( DriverMoved value)?  driverMoved,TResult Function( DriverArrived value)?  driverArrived,TResult Function( RideStarted value)?  started,TResult Function( RideCompleted value)?  completed,TResult Function( RideCancelled value)?  cancelled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RideAccepted() when accepted != null:
return accepted(_that);case DriverMoved() when driverMoved != null:
return driverMoved(_that);case DriverArrived() when driverArrived != null:
return driverArrived(_that);case RideStarted() when started != null:
return started(_that);case RideCompleted() when completed != null:
return completed(_that);case RideCancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RideAccepted value)  accepted,required TResult Function( DriverMoved value)  driverMoved,required TResult Function( DriverArrived value)  driverArrived,required TResult Function( RideStarted value)  started,required TResult Function( RideCompleted value)  completed,required TResult Function( RideCancelled value)  cancelled,}){
final _that = this;
switch (_that) {
case RideAccepted():
return accepted(_that);case DriverMoved():
return driverMoved(_that);case DriverArrived():
return driverArrived(_that);case RideStarted():
return started(_that);case RideCompleted():
return completed(_that);case RideCancelled():
return cancelled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RideAccepted value)?  accepted,TResult? Function( DriverMoved value)?  driverMoved,TResult? Function( DriverArrived value)?  driverArrived,TResult? Function( RideStarted value)?  started,TResult? Function( RideCompleted value)?  completed,TResult? Function( RideCancelled value)?  cancelled,}){
final _that = this;
switch (_that) {
case RideAccepted() when accepted != null:
return accepted(_that);case DriverMoved() when driverMoved != null:
return driverMoved(_that);case DriverArrived() when driverArrived != null:
return driverArrived(_that);case RideStarted() when started != null:
return started(_that);case RideCompleted() when completed != null:
return completed(_that);case RideCancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String rideId,  DriverProfile driver)?  accepted,TResult Function( GeoPoint position)?  driverMoved,TResult Function( String rideId,  String message)?  driverArrived,TResult Function( String rideId,  String message)?  started,TResult Function( String rideId,  String message)?  completed,TResult Function( String? message)?  cancelled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RideAccepted() when accepted != null:
return accepted(_that.rideId,_that.driver);case DriverMoved() when driverMoved != null:
return driverMoved(_that.position);case DriverArrived() when driverArrived != null:
return driverArrived(_that.rideId,_that.message);case RideStarted() when started != null:
return started(_that.rideId,_that.message);case RideCompleted() when completed != null:
return completed(_that.rideId,_that.message);case RideCancelled() when cancelled != null:
return cancelled(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String rideId,  DriverProfile driver)  accepted,required TResult Function( GeoPoint position)  driverMoved,required TResult Function( String rideId,  String message)  driverArrived,required TResult Function( String rideId,  String message)  started,required TResult Function( String rideId,  String message)  completed,required TResult Function( String? message)  cancelled,}) {final _that = this;
switch (_that) {
case RideAccepted():
return accepted(_that.rideId,_that.driver);case DriverMoved():
return driverMoved(_that.position);case DriverArrived():
return driverArrived(_that.rideId,_that.message);case RideStarted():
return started(_that.rideId,_that.message);case RideCompleted():
return completed(_that.rideId,_that.message);case RideCancelled():
return cancelled(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String rideId,  DriverProfile driver)?  accepted,TResult? Function( GeoPoint position)?  driverMoved,TResult? Function( String rideId,  String message)?  driverArrived,TResult? Function( String rideId,  String message)?  started,TResult? Function( String rideId,  String message)?  completed,TResult? Function( String? message)?  cancelled,}) {final _that = this;
switch (_that) {
case RideAccepted() when accepted != null:
return accepted(_that.rideId,_that.driver);case DriverMoved() when driverMoved != null:
return driverMoved(_that.position);case DriverArrived() when driverArrived != null:
return driverArrived(_that.rideId,_that.message);case RideStarted() when started != null:
return started(_that.rideId,_that.message);case RideCompleted() when completed != null:
return completed(_that.rideId,_that.message);case RideCancelled() when cancelled != null:
return cancelled(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RideAccepted implements RideEvent {
  const RideAccepted({required this.rideId, required this.driver});
  

 final  String rideId;
 final  DriverProfile driver;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideAcceptedCopyWith<RideAccepted> get copyWith => _$RideAcceptedCopyWithImpl<RideAccepted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideAccepted&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.driver, driver) || other.driver == driver));
}


@override
int get hashCode => Object.hash(runtimeType,rideId,driver);

@override
String toString() {
  return 'RideEvent.accepted(rideId: $rideId, driver: $driver)';
}


}

/// @nodoc
abstract mixin class $RideAcceptedCopyWith<$Res> implements $RideEventCopyWith<$Res> {
  factory $RideAcceptedCopyWith(RideAccepted value, $Res Function(RideAccepted) _then) = _$RideAcceptedCopyWithImpl;
@useResult
$Res call({
 String rideId, DriverProfile driver
});




}
/// @nodoc
class _$RideAcceptedCopyWithImpl<$Res>
    implements $RideAcceptedCopyWith<$Res> {
  _$RideAcceptedCopyWithImpl(this._self, this._then);

  final RideAccepted _self;
  final $Res Function(RideAccepted) _then;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rideId = null,Object? driver = null,}) {
  return _then(RideAccepted(
rideId: null == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as String,driver: null == driver ? _self.driver : driver // ignore: cast_nullable_to_non_nullable
as DriverProfile,
  ));
}


}

/// @nodoc


class DriverMoved implements RideEvent {
  const DriverMoved(this.position);
  

 final  GeoPoint position;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverMovedCopyWith<DriverMoved> get copyWith => _$DriverMovedCopyWithImpl<DriverMoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverMoved&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,position);

@override
String toString() {
  return 'RideEvent.driverMoved(position: $position)';
}


}

/// @nodoc
abstract mixin class $DriverMovedCopyWith<$Res> implements $RideEventCopyWith<$Res> {
  factory $DriverMovedCopyWith(DriverMoved value, $Res Function(DriverMoved) _then) = _$DriverMovedCopyWithImpl;
@useResult
$Res call({
 GeoPoint position
});




}
/// @nodoc
class _$DriverMovedCopyWithImpl<$Res>
    implements $DriverMovedCopyWith<$Res> {
  _$DriverMovedCopyWithImpl(this._self, this._then);

  final DriverMoved _self;
  final $Res Function(DriverMoved) _then;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? position = null,}) {
  return _then(DriverMoved(
null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as GeoPoint,
  ));
}


}

/// @nodoc


class DriverArrived implements RideEvent {
  const DriverArrived({required this.rideId, required this.message});
  

 final  String rideId;
 final  String message;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DriverArrivedCopyWith<DriverArrived> get copyWith => _$DriverArrivedCopyWithImpl<DriverArrived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DriverArrived&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,rideId,message);

@override
String toString() {
  return 'RideEvent.driverArrived(rideId: $rideId, message: $message)';
}


}

/// @nodoc
abstract mixin class $DriverArrivedCopyWith<$Res> implements $RideEventCopyWith<$Res> {
  factory $DriverArrivedCopyWith(DriverArrived value, $Res Function(DriverArrived) _then) = _$DriverArrivedCopyWithImpl;
@useResult
$Res call({
 String rideId, String message
});




}
/// @nodoc
class _$DriverArrivedCopyWithImpl<$Res>
    implements $DriverArrivedCopyWith<$Res> {
  _$DriverArrivedCopyWithImpl(this._self, this._then);

  final DriverArrived _self;
  final $Res Function(DriverArrived) _then;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rideId = null,Object? message = null,}) {
  return _then(DriverArrived(
rideId: null == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RideStarted implements RideEvent {
  const RideStarted({required this.rideId, required this.message});
  

 final  String rideId;
 final  String message;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideStartedCopyWith<RideStarted> get copyWith => _$RideStartedCopyWithImpl<RideStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideStarted&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,rideId,message);

@override
String toString() {
  return 'RideEvent.started(rideId: $rideId, message: $message)';
}


}

/// @nodoc
abstract mixin class $RideStartedCopyWith<$Res> implements $RideEventCopyWith<$Res> {
  factory $RideStartedCopyWith(RideStarted value, $Res Function(RideStarted) _then) = _$RideStartedCopyWithImpl;
@useResult
$Res call({
 String rideId, String message
});




}
/// @nodoc
class _$RideStartedCopyWithImpl<$Res>
    implements $RideStartedCopyWith<$Res> {
  _$RideStartedCopyWithImpl(this._self, this._then);

  final RideStarted _self;
  final $Res Function(RideStarted) _then;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rideId = null,Object? message = null,}) {
  return _then(RideStarted(
rideId: null == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RideCompleted implements RideEvent {
  const RideCompleted({required this.rideId, required this.message});
  

 final  String rideId;
 final  String message;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideCompletedCopyWith<RideCompleted> get copyWith => _$RideCompletedCopyWithImpl<RideCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideCompleted&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,rideId,message);

@override
String toString() {
  return 'RideEvent.completed(rideId: $rideId, message: $message)';
}


}

/// @nodoc
abstract mixin class $RideCompletedCopyWith<$Res> implements $RideEventCopyWith<$Res> {
  factory $RideCompletedCopyWith(RideCompleted value, $Res Function(RideCompleted) _then) = _$RideCompletedCopyWithImpl;
@useResult
$Res call({
 String rideId, String message
});




}
/// @nodoc
class _$RideCompletedCopyWithImpl<$Res>
    implements $RideCompletedCopyWith<$Res> {
  _$RideCompletedCopyWithImpl(this._self, this._then);

  final RideCompleted _self;
  final $Res Function(RideCompleted) _then;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rideId = null,Object? message = null,}) {
  return _then(RideCompleted(
rideId: null == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RideCancelled implements RideEvent {
  const RideCancelled({this.message});
  

 final  String? message;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideCancelledCopyWith<RideCancelled> get copyWith => _$RideCancelledCopyWithImpl<RideCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideCancelled&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RideEvent.cancelled(message: $message)';
}


}

/// @nodoc
abstract mixin class $RideCancelledCopyWith<$Res> implements $RideEventCopyWith<$Res> {
  factory $RideCancelledCopyWith(RideCancelled value, $Res Function(RideCancelled) _then) = _$RideCancelledCopyWithImpl;
@useResult
$Res call({
 String? message
});




}
/// @nodoc
class _$RideCancelledCopyWithImpl<$Res>
    implements $RideCancelledCopyWith<$Res> {
  _$RideCancelledCopyWithImpl(this._self, this._then);

  final RideCancelled _self;
  final $Res Function(RideCancelled) _then;

/// Create a copy of RideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(RideCancelled(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
