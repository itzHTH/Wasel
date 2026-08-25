import 'package:wasel_core/l10n/core_localizations.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_core/networking/errors/api_error_message.dart';
import 'package:wasel_core/networking/errors/api_error_reason.dart';
import 'package:wasel_core/networking/errors/error_handler.dart';

/// Turns any error into a sentence for the user, in the active language.
String errorMessageOf(
  Object error, {
  String? fallback,
  CoreLocalizations? l10n,
}) {
  final strings = l10n ?? _coreL10n();

  // Providers disagree on what they store: some keep the resolved sentence,
  // others the failure itself. A non-empty String has already been through
  // here, so hand it back rather than resolving it a second time — which
  // would replace a specific message with the generic apology.
  if (error is String) {
    if (error.isNotEmpty) return error;
    return fallback ?? strings.genericError;
  }

  if (error is ErrorHandler) {
    final serverMessage = error.apiErrorModel.displayMessage;
    if (serverMessage != null) return serverMessage;

    final reason = error.apiErrorModel.reason;
    if (reason != null) return _messageFor(strings, reason);
  }

  return fallback ?? strings.genericError;
}

CoreLocalizations _coreL10n() =>
    lookupCoreLocalizations(AppLocalizationController.currentLocale);

String _messageFor(CoreLocalizations l10n, ApiErrorReason reason) =>
    switch (reason) {
      ApiErrorReason.noContent => l10n.errorNoContent,
      ApiErrorReason.badRequest => l10n.errorBadRequest,
      ApiErrorReason.forbidden => l10n.errorForbidden,
      ApiErrorReason.unauthorized => l10n.errorUnauthorized,
      ApiErrorReason.notFound => l10n.errorNotFound,
      ApiErrorReason.internalServerError => l10n.errorServer,
      ApiErrorReason.timeout => l10n.errorTimeout,
      ApiErrorReason.cacheError => l10n.errorCache,
      ApiErrorReason.noInternetConnection => l10n.errorNoInternet,
      ApiErrorReason.roleNotAllowed => l10n.errorRoleNotAllowed,
      ApiErrorReason.routeUnavailable => l10n.errorRouteUnavailable,
      ApiErrorReason.unsupportedPaymentMethod =>
        l10n.errorUnsupportedPaymentMethod,
      // A cancelled request was not a failure the user needs explaining.
      ApiErrorReason.cancelled => l10n.genericError,
      ApiErrorReason.unknown => l10n.genericError,
    };

/// The active language's generic apology, for callers that need it directly.
String get defaultErrorMessage => _coreL10n().genericError;
