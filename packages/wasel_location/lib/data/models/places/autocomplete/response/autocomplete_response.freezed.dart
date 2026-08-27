// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'autocomplete_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AutocompleteResponse {

 List<AutocompleteSuggestion> get suggestions;
/// Create a copy of AutocompleteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutocompleteResponseCopyWith<AutocompleteResponse> get copyWith => _$AutocompleteResponseCopyWithImpl<AutocompleteResponse>(this as AutocompleteResponse, _$identity);

  /// Serializes this AutocompleteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutocompleteResponse&&const DeepCollectionEquality().equals(other.suggestions, suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(suggestions));

@override
String toString() {
  return 'AutocompleteResponse(suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class $AutocompleteResponseCopyWith<$Res>  {
  factory $AutocompleteResponseCopyWith(AutocompleteResponse value, $Res Function(AutocompleteResponse) _then) = _$AutocompleteResponseCopyWithImpl;
@useResult
$Res call({
 List<AutocompleteSuggestion> suggestions
});




}
/// @nodoc
class _$AutocompleteResponseCopyWithImpl<$Res>
    implements $AutocompleteResponseCopyWith<$Res> {
  _$AutocompleteResponseCopyWithImpl(this._self, this._then);

  final AutocompleteResponse _self;
  final $Res Function(AutocompleteResponse) _then;

/// Create a copy of AutocompleteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? suggestions = null,}) {
  return _then(_self.copyWith(
suggestions: null == suggestions ? _self.suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<AutocompleteSuggestion>,
  ));
}

}


/// Adds pattern-matching-related methods to [AutocompleteResponse].
extension AutocompleteResponsePatterns on AutocompleteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutocompleteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutocompleteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutocompleteResponse value)  $default,){
final _that = this;
switch (_that) {
case _AutocompleteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutocompleteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AutocompleteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AutocompleteSuggestion> suggestions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutocompleteResponse() when $default != null:
return $default(_that.suggestions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AutocompleteSuggestion> suggestions)  $default,) {final _that = this;
switch (_that) {
case _AutocompleteResponse():
return $default(_that.suggestions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AutocompleteSuggestion> suggestions)?  $default,) {final _that = this;
switch (_that) {
case _AutocompleteResponse() when $default != null:
return $default(_that.suggestions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutocompleteResponse implements AutocompleteResponse {
  const _AutocompleteResponse({final  List<AutocompleteSuggestion> suggestions = const <AutocompleteSuggestion>[]}): _suggestions = suggestions;
  factory _AutocompleteResponse.fromJson(Map<String, dynamic> json) => _$AutocompleteResponseFromJson(json);

 final  List<AutocompleteSuggestion> _suggestions;
@override@JsonKey() List<AutocompleteSuggestion> get suggestions {
  if (_suggestions is EqualUnmodifiableListView) return _suggestions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggestions);
}


/// Create a copy of AutocompleteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutocompleteResponseCopyWith<_AutocompleteResponse> get copyWith => __$AutocompleteResponseCopyWithImpl<_AutocompleteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutocompleteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutocompleteResponse&&const DeepCollectionEquality().equals(other._suggestions, _suggestions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_suggestions));

@override
String toString() {
  return 'AutocompleteResponse(suggestions: $suggestions)';
}


}

/// @nodoc
abstract mixin class _$AutocompleteResponseCopyWith<$Res> implements $AutocompleteResponseCopyWith<$Res> {
  factory _$AutocompleteResponseCopyWith(_AutocompleteResponse value, $Res Function(_AutocompleteResponse) _then) = __$AutocompleteResponseCopyWithImpl;
@override @useResult
$Res call({
 List<AutocompleteSuggestion> suggestions
});




}
/// @nodoc
class __$AutocompleteResponseCopyWithImpl<$Res>
    implements _$AutocompleteResponseCopyWith<$Res> {
  __$AutocompleteResponseCopyWithImpl(this._self, this._then);

  final _AutocompleteResponse _self;
  final $Res Function(_AutocompleteResponse) _then;

/// Create a copy of AutocompleteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? suggestions = null,}) {
  return _then(_AutocompleteResponse(
suggestions: null == suggestions ? _self._suggestions : suggestions // ignore: cast_nullable_to_non_nullable
as List<AutocompleteSuggestion>,
  ));
}


}


/// @nodoc
mixin _$AutocompleteSuggestion {

 PlacePrediction? get placePrediction;
/// Create a copy of AutocompleteSuggestion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutocompleteSuggestionCopyWith<AutocompleteSuggestion> get copyWith => _$AutocompleteSuggestionCopyWithImpl<AutocompleteSuggestion>(this as AutocompleteSuggestion, _$identity);

  /// Serializes this AutocompleteSuggestion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutocompleteSuggestion&&(identical(other.placePrediction, placePrediction) || other.placePrediction == placePrediction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placePrediction);

@override
String toString() {
  return 'AutocompleteSuggestion(placePrediction: $placePrediction)';
}


}

/// @nodoc
abstract mixin class $AutocompleteSuggestionCopyWith<$Res>  {
  factory $AutocompleteSuggestionCopyWith(AutocompleteSuggestion value, $Res Function(AutocompleteSuggestion) _then) = _$AutocompleteSuggestionCopyWithImpl;
@useResult
$Res call({
 PlacePrediction? placePrediction
});


$PlacePredictionCopyWith<$Res>? get placePrediction;

}
/// @nodoc
class _$AutocompleteSuggestionCopyWithImpl<$Res>
    implements $AutocompleteSuggestionCopyWith<$Res> {
  _$AutocompleteSuggestionCopyWithImpl(this._self, this._then);

  final AutocompleteSuggestion _self;
  final $Res Function(AutocompleteSuggestion) _then;

/// Create a copy of AutocompleteSuggestion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placePrediction = freezed,}) {
  return _then(_self.copyWith(
placePrediction: freezed == placePrediction ? _self.placePrediction : placePrediction // ignore: cast_nullable_to_non_nullable
as PlacePrediction?,
  ));
}
/// Create a copy of AutocompleteSuggestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacePredictionCopyWith<$Res>? get placePrediction {
    if (_self.placePrediction == null) {
    return null;
  }

  return $PlacePredictionCopyWith<$Res>(_self.placePrediction!, (value) {
    return _then(_self.copyWith(placePrediction: value));
  });
}
}


/// Adds pattern-matching-related methods to [AutocompleteSuggestion].
extension AutocompleteSuggestionPatterns on AutocompleteSuggestion {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutocompleteSuggestion value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutocompleteSuggestion() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutocompleteSuggestion value)  $default,){
final _that = this;
switch (_that) {
case _AutocompleteSuggestion():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutocompleteSuggestion value)?  $default,){
final _that = this;
switch (_that) {
case _AutocompleteSuggestion() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlacePrediction? placePrediction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutocompleteSuggestion() when $default != null:
return $default(_that.placePrediction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlacePrediction? placePrediction)  $default,) {final _that = this;
switch (_that) {
case _AutocompleteSuggestion():
return $default(_that.placePrediction);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlacePrediction? placePrediction)?  $default,) {final _that = this;
switch (_that) {
case _AutocompleteSuggestion() when $default != null:
return $default(_that.placePrediction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutocompleteSuggestion implements AutocompleteSuggestion {
  const _AutocompleteSuggestion({this.placePrediction});
  factory _AutocompleteSuggestion.fromJson(Map<String, dynamic> json) => _$AutocompleteSuggestionFromJson(json);

@override final  PlacePrediction? placePrediction;

/// Create a copy of AutocompleteSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutocompleteSuggestionCopyWith<_AutocompleteSuggestion> get copyWith => __$AutocompleteSuggestionCopyWithImpl<_AutocompleteSuggestion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutocompleteSuggestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutocompleteSuggestion&&(identical(other.placePrediction, placePrediction) || other.placePrediction == placePrediction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placePrediction);

@override
String toString() {
  return 'AutocompleteSuggestion(placePrediction: $placePrediction)';
}


}

/// @nodoc
abstract mixin class _$AutocompleteSuggestionCopyWith<$Res> implements $AutocompleteSuggestionCopyWith<$Res> {
  factory _$AutocompleteSuggestionCopyWith(_AutocompleteSuggestion value, $Res Function(_AutocompleteSuggestion) _then) = __$AutocompleteSuggestionCopyWithImpl;
@override @useResult
$Res call({
 PlacePrediction? placePrediction
});


@override $PlacePredictionCopyWith<$Res>? get placePrediction;

}
/// @nodoc
class __$AutocompleteSuggestionCopyWithImpl<$Res>
    implements _$AutocompleteSuggestionCopyWith<$Res> {
  __$AutocompleteSuggestionCopyWithImpl(this._self, this._then);

  final _AutocompleteSuggestion _self;
  final $Res Function(_AutocompleteSuggestion) _then;

/// Create a copy of AutocompleteSuggestion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placePrediction = freezed,}) {
  return _then(_AutocompleteSuggestion(
placePrediction: freezed == placePrediction ? _self.placePrediction : placePrediction // ignore: cast_nullable_to_non_nullable
as PlacePrediction?,
  ));
}

/// Create a copy of AutocompleteSuggestion
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlacePredictionCopyWith<$Res>? get placePrediction {
    if (_self.placePrediction == null) {
    return null;
  }

  return $PlacePredictionCopyWith<$Res>(_self.placePrediction!, (value) {
    return _then(_self.copyWith(placePrediction: value));
  });
}
}


/// @nodoc
mixin _$PlacePrediction {

 String? get placeId; PredictionText? get text; StructuredFormat? get structuredFormat;
/// Create a copy of PlacePrediction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlacePredictionCopyWith<PlacePrediction> get copyWith => _$PlacePredictionCopyWithImpl<PlacePrediction>(this as PlacePrediction, _$identity);

  /// Serializes this PlacePrediction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlacePrediction&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.text, text) || other.text == text)&&(identical(other.structuredFormat, structuredFormat) || other.structuredFormat == structuredFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,text,structuredFormat);

@override
String toString() {
  return 'PlacePrediction(placeId: $placeId, text: $text, structuredFormat: $structuredFormat)';
}


}

/// @nodoc
abstract mixin class $PlacePredictionCopyWith<$Res>  {
  factory $PlacePredictionCopyWith(PlacePrediction value, $Res Function(PlacePrediction) _then) = _$PlacePredictionCopyWithImpl;
@useResult
$Res call({
 String? placeId, PredictionText? text, StructuredFormat? structuredFormat
});


$PredictionTextCopyWith<$Res>? get text;$StructuredFormatCopyWith<$Res>? get structuredFormat;

}
/// @nodoc
class _$PlacePredictionCopyWithImpl<$Res>
    implements $PlacePredictionCopyWith<$Res> {
  _$PlacePredictionCopyWithImpl(this._self, this._then);

  final PlacePrediction _self;
  final $Res Function(PlacePrediction) _then;

/// Create a copy of PlacePrediction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = freezed,Object? text = freezed,Object? structuredFormat = freezed,}) {
  return _then(_self.copyWith(
placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as PredictionText?,structuredFormat: freezed == structuredFormat ? _self.structuredFormat : structuredFormat // ignore: cast_nullable_to_non_nullable
as StructuredFormat?,
  ));
}
/// Create a copy of PlacePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PredictionTextCopyWith<$Res>? get text {
    if (_self.text == null) {
    return null;
  }

  return $PredictionTextCopyWith<$Res>(_self.text!, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of PlacePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StructuredFormatCopyWith<$Res>? get structuredFormat {
    if (_self.structuredFormat == null) {
    return null;
  }

  return $StructuredFormatCopyWith<$Res>(_self.structuredFormat!, (value) {
    return _then(_self.copyWith(structuredFormat: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlacePrediction].
extension PlacePredictionPatterns on PlacePrediction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlacePrediction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlacePrediction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlacePrediction value)  $default,){
final _that = this;
switch (_that) {
case _PlacePrediction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlacePrediction value)?  $default,){
final _that = this;
switch (_that) {
case _PlacePrediction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? placeId,  PredictionText? text,  StructuredFormat? structuredFormat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlacePrediction() when $default != null:
return $default(_that.placeId,_that.text,_that.structuredFormat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? placeId,  PredictionText? text,  StructuredFormat? structuredFormat)  $default,) {final _that = this;
switch (_that) {
case _PlacePrediction():
return $default(_that.placeId,_that.text,_that.structuredFormat);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? placeId,  PredictionText? text,  StructuredFormat? structuredFormat)?  $default,) {final _that = this;
switch (_that) {
case _PlacePrediction() when $default != null:
return $default(_that.placeId,_that.text,_that.structuredFormat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlacePrediction implements PlacePrediction {
  const _PlacePrediction({this.placeId, this.text, this.structuredFormat});
  factory _PlacePrediction.fromJson(Map<String, dynamic> json) => _$PlacePredictionFromJson(json);

@override final  String? placeId;
@override final  PredictionText? text;
@override final  StructuredFormat? structuredFormat;

/// Create a copy of PlacePrediction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlacePredictionCopyWith<_PlacePrediction> get copyWith => __$PlacePredictionCopyWithImpl<_PlacePrediction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlacePredictionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlacePrediction&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.text, text) || other.text == text)&&(identical(other.structuredFormat, structuredFormat) || other.structuredFormat == structuredFormat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,text,structuredFormat);

@override
String toString() {
  return 'PlacePrediction(placeId: $placeId, text: $text, structuredFormat: $structuredFormat)';
}


}

/// @nodoc
abstract mixin class _$PlacePredictionCopyWith<$Res> implements $PlacePredictionCopyWith<$Res> {
  factory _$PlacePredictionCopyWith(_PlacePrediction value, $Res Function(_PlacePrediction) _then) = __$PlacePredictionCopyWithImpl;
@override @useResult
$Res call({
 String? placeId, PredictionText? text, StructuredFormat? structuredFormat
});


@override $PredictionTextCopyWith<$Res>? get text;@override $StructuredFormatCopyWith<$Res>? get structuredFormat;

}
/// @nodoc
class __$PlacePredictionCopyWithImpl<$Res>
    implements _$PlacePredictionCopyWith<$Res> {
  __$PlacePredictionCopyWithImpl(this._self, this._then);

  final _PlacePrediction _self;
  final $Res Function(_PlacePrediction) _then;

/// Create a copy of PlacePrediction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = freezed,Object? text = freezed,Object? structuredFormat = freezed,}) {
  return _then(_PlacePrediction(
placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as PredictionText?,structuredFormat: freezed == structuredFormat ? _self.structuredFormat : structuredFormat // ignore: cast_nullable_to_non_nullable
as StructuredFormat?,
  ));
}

/// Create a copy of PlacePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PredictionTextCopyWith<$Res>? get text {
    if (_self.text == null) {
    return null;
  }

  return $PredictionTextCopyWith<$Res>(_self.text!, (value) {
    return _then(_self.copyWith(text: value));
  });
}/// Create a copy of PlacePrediction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StructuredFormatCopyWith<$Res>? get structuredFormat {
    if (_self.structuredFormat == null) {
    return null;
  }

  return $StructuredFormatCopyWith<$Res>(_self.structuredFormat!, (value) {
    return _then(_self.copyWith(structuredFormat: value));
  });
}
}


/// @nodoc
mixin _$StructuredFormat {

 PredictionText? get mainText; PredictionText? get secondaryText;
/// Create a copy of StructuredFormat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StructuredFormatCopyWith<StructuredFormat> get copyWith => _$StructuredFormatCopyWithImpl<StructuredFormat>(this as StructuredFormat, _$identity);

  /// Serializes this StructuredFormat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StructuredFormat&&(identical(other.mainText, mainText) || other.mainText == mainText)&&(identical(other.secondaryText, secondaryText) || other.secondaryText == secondaryText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mainText,secondaryText);

@override
String toString() {
  return 'StructuredFormat(mainText: $mainText, secondaryText: $secondaryText)';
}


}

/// @nodoc
abstract mixin class $StructuredFormatCopyWith<$Res>  {
  factory $StructuredFormatCopyWith(StructuredFormat value, $Res Function(StructuredFormat) _then) = _$StructuredFormatCopyWithImpl;
@useResult
$Res call({
 PredictionText? mainText, PredictionText? secondaryText
});


$PredictionTextCopyWith<$Res>? get mainText;$PredictionTextCopyWith<$Res>? get secondaryText;

}
/// @nodoc
class _$StructuredFormatCopyWithImpl<$Res>
    implements $StructuredFormatCopyWith<$Res> {
  _$StructuredFormatCopyWithImpl(this._self, this._then);

  final StructuredFormat _self;
  final $Res Function(StructuredFormat) _then;

/// Create a copy of StructuredFormat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mainText = freezed,Object? secondaryText = freezed,}) {
  return _then(_self.copyWith(
mainText: freezed == mainText ? _self.mainText : mainText // ignore: cast_nullable_to_non_nullable
as PredictionText?,secondaryText: freezed == secondaryText ? _self.secondaryText : secondaryText // ignore: cast_nullable_to_non_nullable
as PredictionText?,
  ));
}
/// Create a copy of StructuredFormat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PredictionTextCopyWith<$Res>? get mainText {
    if (_self.mainText == null) {
    return null;
  }

  return $PredictionTextCopyWith<$Res>(_self.mainText!, (value) {
    return _then(_self.copyWith(mainText: value));
  });
}/// Create a copy of StructuredFormat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PredictionTextCopyWith<$Res>? get secondaryText {
    if (_self.secondaryText == null) {
    return null;
  }

  return $PredictionTextCopyWith<$Res>(_self.secondaryText!, (value) {
    return _then(_self.copyWith(secondaryText: value));
  });
}
}


/// Adds pattern-matching-related methods to [StructuredFormat].
extension StructuredFormatPatterns on StructuredFormat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StructuredFormat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StructuredFormat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StructuredFormat value)  $default,){
final _that = this;
switch (_that) {
case _StructuredFormat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StructuredFormat value)?  $default,){
final _that = this;
switch (_that) {
case _StructuredFormat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PredictionText? mainText,  PredictionText? secondaryText)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StructuredFormat() when $default != null:
return $default(_that.mainText,_that.secondaryText);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PredictionText? mainText,  PredictionText? secondaryText)  $default,) {final _that = this;
switch (_that) {
case _StructuredFormat():
return $default(_that.mainText,_that.secondaryText);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PredictionText? mainText,  PredictionText? secondaryText)?  $default,) {final _that = this;
switch (_that) {
case _StructuredFormat() when $default != null:
return $default(_that.mainText,_that.secondaryText);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StructuredFormat implements StructuredFormat {
  const _StructuredFormat({this.mainText, this.secondaryText});
  factory _StructuredFormat.fromJson(Map<String, dynamic> json) => _$StructuredFormatFromJson(json);

@override final  PredictionText? mainText;
@override final  PredictionText? secondaryText;

/// Create a copy of StructuredFormat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StructuredFormatCopyWith<_StructuredFormat> get copyWith => __$StructuredFormatCopyWithImpl<_StructuredFormat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StructuredFormatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StructuredFormat&&(identical(other.mainText, mainText) || other.mainText == mainText)&&(identical(other.secondaryText, secondaryText) || other.secondaryText == secondaryText));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mainText,secondaryText);

@override
String toString() {
  return 'StructuredFormat(mainText: $mainText, secondaryText: $secondaryText)';
}


}

/// @nodoc
abstract mixin class _$StructuredFormatCopyWith<$Res> implements $StructuredFormatCopyWith<$Res> {
  factory _$StructuredFormatCopyWith(_StructuredFormat value, $Res Function(_StructuredFormat) _then) = __$StructuredFormatCopyWithImpl;
@override @useResult
$Res call({
 PredictionText? mainText, PredictionText? secondaryText
});


@override $PredictionTextCopyWith<$Res>? get mainText;@override $PredictionTextCopyWith<$Res>? get secondaryText;

}
/// @nodoc
class __$StructuredFormatCopyWithImpl<$Res>
    implements _$StructuredFormatCopyWith<$Res> {
  __$StructuredFormatCopyWithImpl(this._self, this._then);

  final _StructuredFormat _self;
  final $Res Function(_StructuredFormat) _then;

/// Create a copy of StructuredFormat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mainText = freezed,Object? secondaryText = freezed,}) {
  return _then(_StructuredFormat(
mainText: freezed == mainText ? _self.mainText : mainText // ignore: cast_nullable_to_non_nullable
as PredictionText?,secondaryText: freezed == secondaryText ? _self.secondaryText : secondaryText // ignore: cast_nullable_to_non_nullable
as PredictionText?,
  ));
}

/// Create a copy of StructuredFormat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PredictionTextCopyWith<$Res>? get mainText {
    if (_self.mainText == null) {
    return null;
  }

  return $PredictionTextCopyWith<$Res>(_self.mainText!, (value) {
    return _then(_self.copyWith(mainText: value));
  });
}/// Create a copy of StructuredFormat
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PredictionTextCopyWith<$Res>? get secondaryText {
    if (_self.secondaryText == null) {
    return null;
  }

  return $PredictionTextCopyWith<$Res>(_self.secondaryText!, (value) {
    return _then(_self.copyWith(secondaryText: value));
  });
}
}


/// @nodoc
mixin _$PredictionText {

 String? get text;
/// Create a copy of PredictionText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PredictionTextCopyWith<PredictionText> get copyWith => _$PredictionTextCopyWithImpl<PredictionText>(this as PredictionText, _$identity);

  /// Serializes this PredictionText to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PredictionText&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'PredictionText(text: $text)';
}


}

/// @nodoc
abstract mixin class $PredictionTextCopyWith<$Res>  {
  factory $PredictionTextCopyWith(PredictionText value, $Res Function(PredictionText) _then) = _$PredictionTextCopyWithImpl;
@useResult
$Res call({
 String? text
});




}
/// @nodoc
class _$PredictionTextCopyWithImpl<$Res>
    implements $PredictionTextCopyWith<$Res> {
  _$PredictionTextCopyWithImpl(this._self, this._then);

  final PredictionText _self;
  final $Res Function(PredictionText) _then;

/// Create a copy of PredictionText
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,}) {
  return _then(_self.copyWith(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PredictionText].
extension PredictionTextPatterns on PredictionText {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PredictionText value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PredictionText() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PredictionText value)  $default,){
final _that = this;
switch (_that) {
case _PredictionText():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PredictionText value)?  $default,){
final _that = this;
switch (_that) {
case _PredictionText() when $default != null:
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
case _PredictionText() when $default != null:
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
case _PredictionText():
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
case _PredictionText() when $default != null:
return $default(_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PredictionText implements PredictionText {
  const _PredictionText({this.text});
  factory _PredictionText.fromJson(Map<String, dynamic> json) => _$PredictionTextFromJson(json);

@override final  String? text;

/// Create a copy of PredictionText
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PredictionTextCopyWith<_PredictionText> get copyWith => __$PredictionTextCopyWithImpl<_PredictionText>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PredictionTextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PredictionText&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'PredictionText(text: $text)';
}


}

/// @nodoc
abstract mixin class _$PredictionTextCopyWith<$Res> implements $PredictionTextCopyWith<$Res> {
  factory _$PredictionTextCopyWith(_PredictionText value, $Res Function(_PredictionText) _then) = __$PredictionTextCopyWithImpl;
@override @useResult
$Res call({
 String? text
});




}
/// @nodoc
class __$PredictionTextCopyWithImpl<$Res>
    implements _$PredictionTextCopyWith<$Res> {
  __$PredictionTextCopyWithImpl(this._self, this._then);

  final _PredictionText _self;
  final $Res Function(_PredictionText) _then;

/// Create a copy of PredictionText
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,}) {
  return _then(_PredictionText(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
