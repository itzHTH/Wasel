import 'package:dio/dio.dart';
import 'package:wasal/core/networking/errors/api_error_model.dart';
import 'package:wasal/core/networking/errors/api_errors.dart';

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

/// 3 - ResponseMessage — readable error messages for the user
class ResponseMessage {
  static const String noContent = ApiErrorMessages.noContent;
  static const String badRequest = ApiErrorMessages.badRequestError;
  static const String unauthorized = ApiErrorMessages.unauthorizedError;
  static const String forbidden = ApiErrorMessages.forbiddenError;
  static const String notFound = ApiErrorMessages.notFoundError;
  static const String internalServerError =
      ApiErrorMessages.internalServerError;
  static const String connectTimeout = ApiErrorMessages.timeoutError;
  static const String cancel = ApiErrorMessages.defaultError;
  static const String receiveTimeout = ApiErrorMessages.timeoutError;
  static const String sendTimeout = ApiErrorMessages.timeoutError;
  static const String cacheError = ApiErrorMessages.cacheError;
  static const String noInternetConnection = ApiErrorMessages.noInternetError;
  static const String defaultError = ApiErrorMessages.defaultError;
}

/// 4 - DataSourceExtension — convert all DataSource to ApiErrorModel (get failure type)
extension DataSourceExtension on DataSource {
  ApiErrorModel getFailure() {
    return switch (this) {
      DataSource.noContent => ApiErrorModel(message: ResponseMessage.noContent),
      DataSource.badRequest => ApiErrorModel(
        message: ResponseMessage.badRequest,
      ),
      DataSource.forbidden => ApiErrorModel(message: ResponseMessage.forbidden),
      DataSource.unauthorized => ApiErrorModel(
        message: ResponseMessage.unauthorized,
      ),
      DataSource.notFound => ApiErrorModel(message: ResponseMessage.notFound),
      DataSource.internalServerError => ApiErrorModel(
        message: ResponseMessage.internalServerError,
      ),
      DataSource.connectTimeout => ApiErrorModel(
        message: ResponseMessage.connectTimeout,
      ),
      DataSource.cancel => ApiErrorModel(message: ResponseMessage.cancel),
      DataSource.receiveTimeout => ApiErrorModel(
        message: ResponseMessage.receiveTimeout,
      ),
      DataSource.sendTimeout => ApiErrorModel(
        message: ResponseMessage.sendTimeout,
      ),
      DataSource.cacheError => ApiErrorModel(
        message: ResponseMessage.cacheError,
      ),
      DataSource.noInternetConnection => ApiErrorModel(
        message: ResponseMessage.noInternetConnection,
      ),
      DataSource.defaultError => ApiErrorModel(
        message: ResponseMessage.defaultError,
      ),
    };
  }
}

/// 5 - ErrorHandler — entry point for handling all types of errors
class ErrorHandler implements Exception {
  late ApiErrorModel apiErrorModel;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      apiErrorModel = _handleDioError(error);
    } else {
      apiErrorModel = DataSource.defaultError.getFailure();
    }
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
    };
  }
}

/// ApiInternalStatus — internal response status from the server
class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
