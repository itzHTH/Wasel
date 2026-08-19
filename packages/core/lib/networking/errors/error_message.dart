import 'package:wasel_core/networking/errors/api_error_message.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';

const String defaultErrorMessage = 'حصل خطأ ما';

String errorMessageOf(Object error) {
  if (error is ErrorHandler) {
    return error.apiErrorModel.displayMessage ?? defaultErrorMessage;
  }
  return defaultErrorMessage;
}
