import 'package:wasel_core/networking/errors/error_handler.dart';

const String defaultErrorMessage = 'حصل خطأ ما';

String errorMessageOf(Object error) {
  if (error is ErrorHandler) {
    return error.apiErrorModel.message ?? defaultErrorMessage;
  }
  return defaultErrorMessage;
}
