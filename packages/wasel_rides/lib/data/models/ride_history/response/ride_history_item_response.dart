import 'package:json_annotation/json_annotation.dart';
import 'package:wasel_core/networking/json_num_converters.dart';
import 'package:wasel_rides/domain/entities/ride_history_entry.dart';
import 'package:wasel_rides/domain/entities/ride_history_status.dart';

part 'ride_history_item_response.g.dart';

@JsonSerializable(createToJson: false)
class RideHistoryItemResponse {
  final String? requestedDate;

  final String? requestedTime;

  @JsonKey(fromJson: doubleFromJson)
  final double price;

  final String? status;

  const RideHistoryItemResponse({
    this.requestedDate,
    this.requestedTime,
    required this.price,
    this.status,
  });

  factory RideHistoryItemResponse.fromJson(Map<String, dynamic> json) =>
      _$RideHistoryItemResponseFromJson(json);

  RideHistoryEntry toEntity() => RideHistoryEntry(
    requestedAt: _composeRequestedAt(requestedDate, requestedTime),
    price: price,
    status: RideHistoryStatus.fromApi(status),
  );

  static final RegExp _timeSpanPattern = RegExp(
    r'^(?:(\d+)\.)?(\d{2}):(\d{2}):(\d{2})(?:\.\d{1,7})?$',
  );

  /// Rebuilds a single timestamp from the API's split date + time-of-day.
  ///
  /// Both halves describe one UTC instant, so they are recomposed in UTC and
  /// handed back in local time. Rebuilding them on a local wall clock would
  /// relabel 01:04Z as 01:04 in Baghdad — three hours early, and a day early
  /// for anything logged after local midnight.
  static DateTime _composeRequestedAt(String? date, String? time) {
    final parsedDate = DateTime.tryParse(date?.trim() ?? '');
    if (parsedDate == null) return DateTime.fromMillisecondsSinceEpoch(0);

    final span = _parseTimeSpan(time);
    if (span == null) return parsedDate.toLocal();

    final midnight = parsedDate.isUtc
        ? DateTime.utc(parsedDate.year, parsedDate.month, parsedDate.day)
        : DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

    return midnight.add(span).toLocal();
  }

  static Duration? _parseTimeSpan(String? raw) {
    final match = _timeSpanPattern.firstMatch(raw?.trim() ?? '');
    if (match == null) return null;

    return Duration(
      days: int.tryParse(match.group(1) ?? '') ?? 0,
      hours: int.parse(match.group(2)!),
      minutes: int.parse(match.group(3)!),
      seconds: int.parse(match.group(4)!),
    );
  }
}
