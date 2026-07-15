import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';

/// Presents the "ride cancelled" alert over the map using the shared [AppDialog].
/// [reason] explains why the ride ended; [onDismiss] runs after the rider
/// acknowledges (e.g. to navigate back home). The dialog is non-dismissible so
/// the rider must acknowledge before returning.
Future<void> showRideCancelledDialog(
  BuildContext context, {
  required String reason,
  required VoidCallback onDismiss,
}) async {
  await AppDialog.show(
    context,
    title: 'انلغت الرحلة',
    message: reason,
    confirmLabel: 'العودة للرئيسية',
    icon: Icons.cancel_outlined,
    barrierDismissible: false,
  );
  onDismiss();
}
