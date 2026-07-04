// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ride_draft_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RideDraftState {

 PickingStage get stage; LatLng? get pickup; String? get pickupLabel; LatLng? get dropoff; String? get dropoffLabel;
/// Create a copy of RideDraftState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RideDraftStateCopyWith<RideDraftState> get copyWith => _$RideDraftStateCopyWithImpl<RideDraftState>(this as RideDraftState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RideDraftState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.pickup, pickup) || other.pickup == pickup)&&(identical(other.pickupLabel, pickupLabel) || other.pickupLabel == pickupLabel)&&(identical(other.dropoff, dropoff) || other.dropoff == dropoff)&&(identical(other.dropoffLabel, dropoffLabel) || other.dropoffLabel == dropoffLabel));
}


@override
int get hashCode => Object.hash(runtimeType,stage,pickup,pickupLabel,dropoff,dropoffLabel);

@override
String toString() {
  return 'RideDraftState(stage: $stage, pickup: $pickup, pickupLabel: $pickupLabel, dropoff: $dropoff, dropoffLabel: $dropoffLabel)';
}


}

/// @nodoc
abstract mixin class $RideDraftStateCopyWith<$Res>  {
  factory $RideDraftStateCopyWith(RideDraftState value, $Res Function(RideDraftState) _then) = _$RideDraftStateCopyWithImpl;
@useResult
$Res call({
 PickingStage stage, LatLng? pickup, String? pickupLabel, LatLng? dropoff, String? dropoffLabel
});




}
/// @nodoc
class _$RideDraftStateCopyWithImpl<$Res>
    implements $RideDraftStateCopyWith<$Res> {
  _$RideDraftStateCopyWithImpl(this._self, this._then);

  final RideDraftState _self;
  final $Res Function(RideDraftState) _then;

/// Create a copy of RideDraftState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? pickup = freezed,Object? pickupLabel = freezed,Object? dropoff = freezed,Object? dropoffLabel = freezed,}) {
  return _then(_self.copyWith(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PickingStage,pickup: freezed == pickup ? _self.pickup : pickup // ignore: cast_nullable_to_non_nullable
as LatLng?,pickupLabel: freezed == pickupLabel ? _self.pickupLabel : pickupLabel // ignore: cast_nullable_to_non_nullable
as String?,dropoff: freezed == dropoff ? _self.dropoff : dropoff // ignore: cast_nullable_to_non_nullable
as LatLng?,dropoffLabel: freezed == dropoffLabel ? _self.dropoffLabel : dropoffLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RideDraftState].
extension RideDraftStatePatterns on RideDraftState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RideDraftState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RideDraftState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RideDraftState value)  $default,){
final _that = this;
switch (_that) {
case _RideDraftState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RideDraftState value)?  $default,){
final _that = this;
switch (_that) {
case _RideDraftState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PickingStage stage,  LatLng? pickup,  String? pickupLabel,  LatLng? dropoff,  String? dropoffLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RideDraftState() when $default != null:
return $default(_that.stage,_that.pickup,_that.pickupLabel,_that.dropoff,_that.dropoffLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PickingStage stage,  LatLng? pickup,  String? pickupLabel,  LatLng? dropoff,  String? dropoffLabel)  $default,) {final _that = this;
switch (_that) {
case _RideDraftState():
return $default(_that.stage,_that.pickup,_that.pickupLabel,_that.dropoff,_that.dropoffLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PickingStage stage,  LatLng? pickup,  String? pickupLabel,  LatLng? dropoff,  String? dropoffLabel)?  $default,) {final _that = this;
switch (_that) {
case _RideDraftState() when $default != null:
return $default(_that.stage,_that.pickup,_that.pickupLabel,_that.dropoff,_that.dropoffLabel);case _:
  return null;

}
}

}

/// @nodoc


class _RideDraftState extends RideDraftState {
  const _RideDraftState({this.stage = PickingStage.pickup, this.pickup, this.pickupLabel, this.dropoff, this.dropoffLabel}): super._();
  

@override@JsonKey() final  PickingStage stage;
@override final  LatLng? pickup;
@override final  String? pickupLabel;
@override final  LatLng? dropoff;
@override final  String? dropoffLabel;

/// Create a copy of RideDraftState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RideDraftStateCopyWith<_RideDraftState> get copyWith => __$RideDraftStateCopyWithImpl<_RideDraftState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RideDraftState&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.pickup, pickup) || other.pickup == pickup)&&(identical(other.pickupLabel, pickupLabel) || other.pickupLabel == pickupLabel)&&(identical(other.dropoff, dropoff) || other.dropoff == dropoff)&&(identical(other.dropoffLabel, dropoffLabel) || other.dropoffLabel == dropoffLabel));
}


@override
int get hashCode => Object.hash(runtimeType,stage,pickup,pickupLabel,dropoff,dropoffLabel);

@override
String toString() {
  return 'RideDraftState(stage: $stage, pickup: $pickup, pickupLabel: $pickupLabel, dropoff: $dropoff, dropoffLabel: $dropoffLabel)';
}


}

/// @nodoc
abstract mixin class _$RideDraftStateCopyWith<$Res> implements $RideDraftStateCopyWith<$Res> {
  factory _$RideDraftStateCopyWith(_RideDraftState value, $Res Function(_RideDraftState) _then) = __$RideDraftStateCopyWithImpl;
@override @useResult
$Res call({
 PickingStage stage, LatLng? pickup, String? pickupLabel, LatLng? dropoff, String? dropoffLabel
});




}
/// @nodoc
class __$RideDraftStateCopyWithImpl<$Res>
    implements _$RideDraftStateCopyWith<$Res> {
  __$RideDraftStateCopyWithImpl(this._self, this._then);

  final _RideDraftState _self;
  final $Res Function(_RideDraftState) _then;

/// Create a copy of RideDraftState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? pickup = freezed,Object? pickupLabel = freezed,Object? dropoff = freezed,Object? dropoffLabel = freezed,}) {
  return _then(_RideDraftState(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as PickingStage,pickup: freezed == pickup ? _self.pickup : pickup // ignore: cast_nullable_to_non_nullable
as LatLng?,pickupLabel: freezed == pickupLabel ? _self.pickupLabel : pickupLabel // ignore: cast_nullable_to_non_nullable
as String?,dropoff: freezed == dropoff ? _self.dropoff : dropoff // ignore: cast_nullable_to_non_nullable
as LatLng?,dropoffLabel: freezed == dropoffLabel ? _self.dropoffLabel : dropoffLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
