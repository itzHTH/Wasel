/// Why a ride may not be requested with the chosen payment method.
///
/// The policy returns the reason rather than a sentence so the domain layer
/// stays free of user-facing copy; the UI turns it into a localized message.
enum PaymentBlocker { missingCard, insufficientWallet }
