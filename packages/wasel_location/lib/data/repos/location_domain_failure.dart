import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/api_error_model.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';

/// Builds an `ApiResults.failure` that keeps [message] intact.
//! Internal to this package — repositories use it, nothing exports it.
ApiResults<T> domainFailure<T>(String message) {
  final error = ErrorHandler.handle(null)
    ..apiErrorModel = ApiErrorModel(succeeded: false, message: message);

  return ApiResults.failure(error);
}
