enum ApiErrorReason {
  noContent,
  badRequest,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  timeout,
  cancelled,
  cacheError,
  noInternetConnection,

  /// The credentials were valid, but not for this app.
  roleNotAllowed,

  /// Too few points to draw a line between.
  routeUnavailable,

  /// The ride cannot be settled with the method chosen.
  unsupportedPaymentMethod,

  unknown,
}
