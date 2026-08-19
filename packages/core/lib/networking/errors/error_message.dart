import 'package:wasel_core/networking/errors/api_error_message.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';

const String defaultErrorMessage = 'حصل خطأ ما';

String errorMessageOf(Object error, {String fallback = defaultErrorMessage}) {
  if (error is ErrorHandler) {
    return error.apiErrorModel.displayMessage ?? fallback;
  }
  return fallback;
}
