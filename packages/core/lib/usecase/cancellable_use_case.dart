import 'package:dio/dio.dart';

/// A use case that supports request cancellation via Dio's [CancelToken].
///
/// Each call to [call] creates a fresh [CancelToken], so only the latest
/// request can be cancelled. Previous tokens are automatically invalidated.
///
//! Cancel from State Management: If you want to cancel a request when a widget is disposed,

abstract class CancellableUseCase<T, P> {
  CancelToken _cancelToken = CancelToken();

  /// The cancel token for the current (latest) request.
  CancelToken get cancelToken => _cancelToken;

  /// Whether the current request has been cancelled.
  bool get isCancelled => _cancelToken.isCancelled;

  /// Override this to execute the actual business logic.
  ///
  /// The [cancelToken] is passed down to the repository/service layer
  /// so Dio can abort the HTTP request if [cancel] is called.
  Future<T> execute(P params, CancelToken cancelToken);

  /// Calls [execute] with a fresh [CancelToken].
  ///
  /// If a previous request is still in-flight, it will NOT be
  /// automatically cancelled — call [cancel] first if needed.
  Future<T> call(P params) {
    _cancelToken = CancelToken();
    return execute(params, _cancelToken);
  }

  /// Cancels the in-flight request (if any).
  ///
  /// Safe to call multiple times — does nothing if already cancelled
  /// or if no request is in-flight.
  void cancel([String reason = 'Cancelled by user']) {
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel(reason);
    }
  }
}
