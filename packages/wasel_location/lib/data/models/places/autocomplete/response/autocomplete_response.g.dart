// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AutocompleteResponse _$AutocompleteResponseFromJson(
  Map<String, dynamic> json,
) => _AutocompleteResponse(
  suggestions:
      (json['suggestions'] as List<dynamic>?)
          ?.map(
            (e) => AutocompleteSuggestion.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <AutocompleteSuggestion>[],
);

Map<String, dynamic> _$AutocompleteResponseToJson(
  _AutocompleteResponse instance,
) => <String, dynamic>{'suggestions': instance.suggestions};

_AutocompleteSuggestion _$AutocompleteSuggestionFromJson(
  Map<String, dynamic> json,
) => _AutocompleteSuggestion(
  placePrediction: json['placePrediction'] == null
      ? null
      : PlacePrediction.fromJson(
          json['placePrediction'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AutocompleteSuggestionToJson(
  _AutocompleteSuggestion instance,
) => <String, dynamic>{'placePrediction': instance.placePrediction};

_PlacePrediction _$PlacePredictionFromJson(Map<String, dynamic> json) =>
    _PlacePrediction(
      placeId: json['placeId'] as String?,
      text: json['text'] == null
          ? null
          : PredictionText.fromJson(json['text'] as Map<String, dynamic>),
      structuredFormat: json['structuredFormat'] == null
          ? null
          : StructuredFormat.fromJson(
              json['structuredFormat'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PlacePredictionToJson(_PlacePrediction instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'text': instance.text,
      'structuredFormat': instance.structuredFormat,
    };

_StructuredFormat _$StructuredFormatFromJson(Map<String, dynamic> json) =>
    _StructuredFormat(
      mainText: json['mainText'] == null
          ? null
          : PredictionText.fromJson(json['mainText'] as Map<String, dynamic>),
      secondaryText: json['secondaryText'] == null
          ? null
          : PredictionText.fromJson(
              json['secondaryText'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$StructuredFormatToJson(_StructuredFormat instance) =>
    <String, dynamic>{
      'mainText': instance.mainText,
      'secondaryText': instance.secondaryText,
    };

_PredictionText _$PredictionTextFromJson(Map<String, dynamic> json) =>
    _PredictionText(text: json['text'] as String?);

Map<String, dynamic> _$PredictionTextToJson(_PredictionText instance) =>
    <String, dynamic>{'text': instance.text};
