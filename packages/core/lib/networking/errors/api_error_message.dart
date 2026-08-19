import 'package:wasel_core/networking/errors/api_error_model.dart';

extension ApiErrorMessage on ApiErrorModel {
  /// The server sends validation detail in [errors] and sometimes leaves
  /// [message] blank, which would otherwise surface as an empty error.
  String? get displayMessage {
    final text = message?.trim();
    if (text != null && text.isNotEmpty) return text;

    for (final entry in errors?.values ?? const <List<String>>[]) {
      for (final line in entry) {
        final trimmed = line.trim();
        if (trimmed.isNotEmpty) return trimmed;
      }
    }

    return null;
  }
}
