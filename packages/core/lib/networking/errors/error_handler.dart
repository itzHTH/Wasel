import 'package:dio/dio.dart';
import 'package:wasel_core/networking/errors/api_error_model.dart';
import 'package:wasel_core/networking/errors/api_error_reason.dart';

/// 1 - DataSource — represents all possible error states (server or local)
enum DataSource {
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

/// 2 - ResponseCode — HTTP codes + local codes (negative)
class ResponseCode {
  // HTTP codes
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int apiLogicError = 422;
  static const int internalServerError = 500;

  // Local codes (not in HTTP, use negative numbers)
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

/// 3 - DataSourceExtension — convert a DataSource into an ApiErrorModel
/// carrying the reason. The wording is chosen by the UI, once the active
/// language is known.
extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() => ApiErrorModel(succeeded: false, reason: reason);

  ApiErrorReason get reason {
    return switch (this) {
      DataSource.noContent => ApiErrorReason.noContent,
      DataSource.badRequest => ApiErrorReason.badRequest,
      DataSource.forbidden => ApiErrorReason.forbidden,
      DataSource.unauthorized => ApiErrorReason.unauthorized,
      DataSource.notFound => ApiErrorReason.notFound,
      DataSource.internalServerError => ApiErrorReason.internalServerError,
      DataSource.connectTimeout => ApiErrorReason.timeout,
      DataSource.receiveTimeout => ApiErrorReason.timeout,
      DataSource.sendTimeout => ApiErrorReason.timeout,
      DataSource.cancel => ApiErrorReason.cancelled,
      DataSource.cacheError => ApiErrorReason.cacheError,
      DataSource.noInternetConnection => ApiErrorReason.noInternetConnection,
      DataSource.defaultError => ApiErrorReason.unknown,
    };
  }
}

/// 4 - ErrorHandler — entry point for handling all types of errors
class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  bool isCancelled = false;

  /// Null whenever the request never reached a response — a timeout, a dropped
  /// connection, a cancellation.
  int? statusCode;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      isCancelled = error.type == DioExceptionType.cancel;
      statusCode = error.response?.statusCode;
      apiErrorModel = _handleDioError(error);
    } else {
      apiErrorModel = DataSource.defaultError.getFailure();
    }
  }

  ErrorHandler.message(String message) {
    apiErrorModel = ApiErrorModel(succeeded: false, message: message);
  }

  /// A failure decided on the device. Carries why, not what to say about it.
  ErrorHandler.reason(ApiErrorReason reason) {
    apiErrorModel = ApiErrorModel(succeeded: false, reason: reason);
  }

  /// convert DioException to ApiErrorModel according to the error type
  static ApiErrorModel _handleDioError(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout =>
        DataSource.connectTimeout.getFailure(),

      DioExceptionType.sendTimeout => DataSource.sendTimeout.getFailure(),

      DioExceptionType.receiveTimeout => DataSource.receiveTimeout.getFailure(),

      // The error came from the server → try to convert the JSON to ApiErrorModel
      DioExceptionType.badResponse =>
        error.response?.data != null
            ? ApiErrorModel.fromJson(error.response!.data)
            : DataSource.defaultError.getFailure(),

      // Network problem (internet connection)
      DioExceptionType.connectionError =>
        DataSource.noInternetConnection.getFailure(),

      DioExceptionType.cancel => DataSource.cancel.getFailure(),

      // SSL certificate error
      DioExceptionType.badCertificate => DataSource.defaultError.getFailure(),

      // Any other unknown error
      DioExceptionType.unknown =>
        error.response?.data != null
            ? ApiErrorModel.fromJson(error.response!.data)
            : DataSource.defaultError.getFailure(),
      DioExceptionType.transformTimeout =>
        error.response?.data != null
            ? ApiErrorModel.fromJson(error.response!.data)
            : DataSource.defaultError.getFailure(),
    };
  }
}

/// ApiInternalStatus — internal response status from the server
class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
