import 'package:wasel_core/networking/api_results.dart';
import 'package:wasel_core/networking/errors/api_error_model.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';

/// Builds an `ApiResults.failure` that keeps [message] intact.
///
/// `ErrorHandler.handle` only inspects `DioException`; every other error falls
/// through to `DataSource.defaultError`, which replaces whatever was thrown with
/// one generic Arabic string. That is correct for transport errors and wrong for
/// failures this layer raises itself.
///
/// It is also an active bug in the code being extracted: the driver's geocoding
/// repo does `ErrorHandler.handle(Exception('لا يوجد اسم لهذا الموقع حاليا'))`,
/// and the message the author wrote is silently discarded before it reaches the
/// user. Routing self-raised failures through here fixes that without changing
/// the `ApiResults` contract the rest of the app pattern-matches on.
///
/// Internal to this package — repositories use it, nothing exports it.
ApiResults<T> domainFailure<T>(String message) {
  final error = ErrorHandler.handle(null)
    ..apiErrorModel = ApiErrorModel(succeeded: false, message: message);

  return ApiResults.failure(error);
}
