// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hub_ride_events.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HubRideEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HubRideEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HubRideEvent()';
}


}

/// @nodoc
class $HubRideEventCopyWith<$Res>  {
$HubRideEventCopyWith(HubRideEvent _, $Res Function(HubRideEvent) __);
}


/// Adds pattern-matching-related methods to [HubRideEvent].
extension HubRideEventPatterns on HubRideEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReceiveRideRequest value)?  receiveRideRequest,TResult Function( HideRideRequest value)?  hideRideRequest,TResult Function( ProfileReviewed value)?  profileReviewed,TResult Function( RideCancelled value)?  cancelled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReceiveRideRequest() when receiveRideRequest != null:
return receiveRideRequest(_that);case HideRideRequest() when hideRideRequest != null:
return hideRideRequest(_that);case ProfileReviewed() when profileReviewed != null:
return profileReviewed(_that);case RideCancelled() when cancelled != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReceiveRideRequest value)  receiveRideRequest,required TResult Function( HideRideRequest value)  hideRideRequest,required TResult Function( ProfileReviewed value)  profileReviewed,required TResult Function( RideCancelled value)  cancelled,}){
final _that = this;
switch (_that) {
case ReceiveRideRequest():
return receiveRideRequest(_that);case HideRideRequest():
return hideRideRequest(_that);case ProfileReviewed():
return profileReviewed(_that);case RideCancelled():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReceiveRideRequest value)?  receiveRideRequest,TResult? Function( HideRideRequest value)?  hideRideRequest,TResult? Function( ProfileReviewed value)?  profileReviewed,TResult? Function( RideCancelled value)?  cancelled,}){
final _that = this;
switch (_that) {
case ReceiveRideRequest() when receiveRideRequest != null:
return receiveRideRequest(_that);case HideRideRequest() when hideRideRequest != null:
return hideRideRequest(_that);case ProfileReviewed() when profileReviewed != null:
return profileReviewed(_that);case RideCancelled() when cancelled != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String rideId,  LatLngDto position,  LatLngDto dropPosition,  double calculatedPrice,  String paymentMethod,  String message)?  receiveRideRequest,TResult Function( String rideId)?  hideRideRequest,TResult Function( bool isApproved,  String message)?  profileReviewed,TResult Function( String? message)?  cancelled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReceiveRideRequest() when receiveRideRequest != null:
return receiveRideRequest(_that.rideId,_that.position,_that.dropPosition,_that.calculatedPrice,_that.paymentMethod,_that.message);case HideRideRequest() when hideRideRequest != null:
return hideRideRequest(_that.rideId);case ProfileReviewed() when profileReviewed != null:
return profileReviewed(_that.isApproved,_that.message);case RideCancelled() when cancelled != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String rideId,  LatLngDto position,  LatLngDto dropPosition,  double calculatedPrice,  String paymentMethod,  String message)  receiveRideRequest,required TResult Function( String rideId)  hideRideRequest,required TResult Function( bool isApproved,  String message)  profileReviewed,required TResult Function( String? message)  cancelled,}) {final _that = this;
switch (_that) {
case ReceiveRideRequest():
return receiveRideRequest(_that.rideId,_that.position,_that.dropPosition,_that.calculatedPrice,_that.paymentMethod,_that.message);case HideRideRequest():
return hideRideRequest(_that.rideId);case ProfileReviewed():
return profileReviewed(_that.isApproved,_that.message);case RideCancelled():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String rideId,  LatLngDto position,  LatLngDto dropPosition,  double calculatedPrice,  String paymentMethod,  String message)?  receiveRideRequest,TResult? Function( String rideId)?  hideRideRequest,TResult? Function( bool isApproved,  String message)?  profileReviewed,TResult? Function( String? message)?  cancelled,}) {final _that = this;
switch (_that) {
case ReceiveRideRequest() when receiveRideRequest != null:
return receiveRideRequest(_that.rideId,_that.position,_that.dropPosition,_that.calculatedPrice,_that.paymentMethod,_that.message);case HideRideRequest() when hideRideRequest != null:
return hideRideRequest(_that.rideId);case ProfileReviewed() when profileReviewed != null:
return profileReviewed(_that.isApproved,_that.message);case RideCancelled() when cancelled != null:
return cancelled(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ReceiveRideRequest implements HubRideEvent {
  const ReceiveRideRequest({required this.rideId, required this.position, required this.dropPosition, required this.calculatedPrice, required this.paymentMethod, required this.message});
  

 final  String rideId;
 final  LatLngDto position;
 final  LatLngDto dropPosition;
 final  double calculatedPrice;
 final  String paymentMethod;
 final  String message;

/// Create a copy of HubRideEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReceiveRideRequestCopyWith<ReceiveRideRequest> get copyWith => _$ReceiveRideRequestCopyWithImpl<ReceiveRideRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReceiveRideRequest&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.position, position) || other.position == position)&&(identical(other.dropPosition, dropPosition) || other.dropPosition == dropPosition)&&(identical(other.calculatedPrice, calculatedPrice) || other.calculatedPrice == calculatedPrice)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,rideId,position,dropPosition,calculatedPrice,paymentMethod,message);

@override
String toString() {
  return 'HubRideEvent.receiveRideRequest(rideId: $rideId, position: $position, dropPosition: $dropPosition, calculatedPrice: $calculatedPrice, paymentMethod: $paymentMethod, message: $message)';
}


}

/// @nodoc
abstract mixin class $ReceiveRideRequestCopyWith<$Res> implements $HubRideEventCopyWith<$Res> {
  factory $ReceiveRideRequestCopyWith(ReceiveRideRequest value, $Res Function(ReceiveRideRequest) _then) = _$ReceiveRideRequestCopyWithImpl;
@useResult
$Res call({
 String rideId, LatLngDto position, LatLngDto dropPosition, double calculatedPrice, String paymentMethod, String message
});


$LatLngDtoCopyWith<$Res> get position;$LatLngDtoCopyWith<$Res> get dropPosition;

}
/// @nodoc
class _$ReceiveRideRequestCopyWithImpl<$Res>
    implements $ReceiveRideRequestCopyWith<$Res> {
  _$ReceiveRideRequestCopyWithImpl(this._self, this._then);

  final ReceiveRideRequest _self;
  final $Res Function(ReceiveRideRequest) _then;

/// Create a copy of HubRideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rideId = null,Object? position = null,Object? dropPosition = null,Object? calculatedPrice = null,Object? paymentMethod = null,Object? message = null,}) {
  return _then(ReceiveRideRequest(
rideId: null == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as LatLngDto,dropPosition: null == dropPosition ? _self.dropPosition : dropPosition // ignore: cast_nullable_to_non_nullable
as LatLngDto,calculatedPrice: null == calculatedPrice ? _self.calculatedPrice : calculatedPrice // ignore: cast_nullable_to_non_nullable
as double,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of HubRideEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatLngDtoCopyWith<$Res> get position {
  
  return $LatLngDtoCopyWith<$Res>(_self.position, (value) {
    return _then(_self.copyWith(position: value));
  });
}/// Create a copy of HubRideEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatLngDtoCopyWith<$Res> get dropPosition {
  
  return $LatLngDtoCopyWith<$Res>(_self.dropPosition, (value) {
    return _then(_self.copyWith(dropPosition: value));
  });
}
}

/// @nodoc


class HideRideRequest implements HubRideEvent {
  const HideRideRequest(this.rideId);
  

 final  String rideId;

/// Create a copy of HubRideEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HideRideRequestCopyWith<HideRideRequest> get copyWith => _$HideRideRequestCopyWithImpl<HideRideRequest>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HideRideRequest&&(identical(other.rideId, rideId) || other.rideId == rideId));
}


@override
int get hashCode => Object.hash(runtimeType,rideId);

@override
String toString() {
  return 'HubRideEvent.hideRideRequest(rideId: $rideId)';
}


}

/// @nodoc
abstract mixin class $HideRideRequestCopyWith<$Res> implements $HubRideEventCopyWith<$Res> {
  factory $HideRideRequestCopyWith(HideRideRequest value, $Res Function(HideRideRequest) _then) = _$HideRideRequestCopyWithImpl;
@useResult
$Res call({
 String rideId
});




}
/// @nodoc
class _$HideRideRequestCopyWithImpl<$Res>
    implements $HideRideRequestCopyWith<$Res> {
  _$HideRideRequestCopyWithImpl(this._self, this._then);

  final HideRideRequest _self;
  final $Res Function(HideRideRequest) _then;

/// Create a copy of HubRideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rideId = null,}) {
  return _then(HideRideRequest(
null == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProfileReviewed implements HubRideEvent {
  const ProfileReviewed({required this.isApproved, required this.message});
  

 final  bool isApproved;
 final  String message;

/// Create a copy of HubRideEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileReviewedCopyWith<ProfileReviewed> get copyWith => _$ProfileReviewedCopyWithImpl<ProfileReviewed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileReviewed&&(identical(other.isApproved, isApproved) || other.isApproved == isApproved)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,isApproved,message);

@override
String toString() {
  return 'HubRideEvent.profileReviewed(isApproved: $isApproved, message: $message)';
}


}

/// @nodoc
abstract mixin class $ProfileReviewedCopyWith<$Res> implements $HubRideEventCopyWith<$Res> {
  factory $ProfileReviewedCopyWith(ProfileReviewed value, $Res Function(ProfileReviewed) _then) = _$ProfileReviewedCopyWithImpl;
@useResult
$Res call({
 bool isApproved, String message
});




}
/// @nodoc
class _$ProfileReviewedCopyWithImpl<$Res>
    implements $ProfileReviewedCopyWith<$Res> {
  _$ProfileReviewedCopyWithImpl(this._self, this._then);

  final ProfileReviewed _self;
  final $Res Function(ProfileReviewed) _then;

/// Create a copy of HubRideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isApproved = null,Object? message = null,}) {
  return _then(ProfileReviewed(
isApproved: null == isApproved ? _self.isApproved : isApproved // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RideCancelled implements HubRideEvent {
  const RideCancelled({this.message});
  

 final  String? message;

/// Create a copy of HubRideEvent
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
  return 'HubRideEvent.cancelled(message: $message)';
}


}

/// @nodoc
abstract mixin class $RideCancelledCopyWith<$Res> implements $HubRideEventCopyWith<$Res> {
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

/// Create a copy of HubRideEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,}) {
  return _then(RideCancelled(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$LatLngDto {

 double get lat; double get lng;
/// Create a copy of LatLngDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatLngDtoCopyWith<LatLngDto> get copyWith => _$LatLngDtoCopyWithImpl<LatLngDto>(this as LatLngDto, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatLngDto&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lng);

@override
String toString() {
  return 'LatLngDto(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class $LatLngDtoCopyWith<$Res>  {
  factory $LatLngDtoCopyWith(LatLngDto value, $Res Function(LatLngDto) _then) = _$LatLngDtoCopyWithImpl;
@useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class _$LatLngDtoCopyWithImpl<$Res>
    implements $LatLngDtoCopyWith<$Res> {
  _$LatLngDtoCopyWithImpl(this._self, this._then);

  final LatLngDto _self;
  final $Res Function(LatLngDto) _then;

/// Create a copy of LatLngDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(_self.copyWith(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LatLngDto].
extension LatLngDtoPatterns on LatLngDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatLngDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatLngDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatLngDto value)  $default,){
final _that = this;
switch (_that) {
case _LatLngDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatLngDto value)?  $default,){
final _that = this;
switch (_that) {
case _LatLngDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double lat,  double lng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatLngDto() when $default != null:
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double lat,  double lng)  $default,) {final _that = this;
switch (_that) {
case _LatLngDto():
return $default(_that.lat,_that.lng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double lat,  double lng)?  $default,) {final _that = this;
switch (_that) {
case _LatLngDto() when $default != null:
return $default(_that.lat,_that.lng);case _:
  return null;

}
}

}

/// @nodoc


class _LatLngDto implements LatLngDto {
  const _LatLngDto({required this.lat, required this.lng});
  

@override final  double lat;
@override final  double lng;

/// Create a copy of LatLngDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatLngDtoCopyWith<_LatLngDto> get copyWith => __$LatLngDtoCopyWithImpl<_LatLngDto>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatLngDto&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lng);

@override
String toString() {
  return 'LatLngDto(lat: $lat, lng: $lng)';
}


}

/// @nodoc
abstract mixin class _$LatLngDtoCopyWith<$Res> implements $LatLngDtoCopyWith<$Res> {
  factory _$LatLngDtoCopyWith(_LatLngDto value, $Res Function(_LatLngDto) _then) = __$LatLngDtoCopyWithImpl;
@override @useResult
$Res call({
 double lat, double lng
});




}
/// @nodoc
class __$LatLngDtoCopyWithImpl<$Res>
    implements _$LatLngDtoCopyWith<$Res> {
  __$LatLngDtoCopyWithImpl(this._self, this._then);

  final _LatLngDto _self;
  final $Res Function(_LatLngDto) _then;

/// Create a copy of LatLngDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,}) {
  return _then(_LatLngDto(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
