import 'package:wasel_core/networking/json_num_converters.dart';

class HubPayload {
  const HubPayload._(this._fields);

  final Map<String, Object?> _fields;

  static HubPayload? of(List<Object?>? args) {
    final first = args?.firstOrNull;
    if (first is! Map) return null;

    return HubPayload._({
      for (final entry in first.entries)
        entry.key.toString().trim().toLowerCase(): entry.value,
    });
  }

  Object? operator [](String key) => _fields[key.toLowerCase()];

  String? text(String key) => textOf(this[key]);

  String? loose(String key) => looseOf(this[key]);

  String? message(String key) => messageOf(this[key]);

  double? number(String key) => numberOf(this[key]);

  static String? textOf(Object? raw) {
    if (raw is! String) return null;
    final trimmed = raw.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static String? looseOf(Object? raw) {
    final trimmed = raw?.toString().trim();
    return (trimmed == null || trimmed.isEmpty) ? null : trimmed;
  }

  static String? messageOf(Object? raw) => switch (raw) {
    null => null,
    String text => text,
    Map map => (map['value'] ?? map['name'])?.toString(),
    _ => raw.toString(),
  };

  static double? numberOf(Object? raw) => nullableDoubleFromJson(raw);
}
