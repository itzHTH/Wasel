class ForegroundServiceException implements Exception {
  const ForegroundServiceException(this.cause);

  final Object? cause;

  @override
  String toString() => 'ForegroundServiceException: $cause';
}
