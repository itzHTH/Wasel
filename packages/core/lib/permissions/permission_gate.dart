import 'package:flutter/material.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wasel_core/widgets/app_dialog.dart';

/// Requests [permission] and returns whether it ended up usable.
///
/// Flow:
/// - already granted (or limited) → `true`
/// - undetermined / denied → request once and honour the result
/// - permanently denied / restricted → show the general [AppDialog] offering an
///   "open settings" action (which deep-links via [openAppSettings]) → `false`
///
/// Branching is done on the *result of [Permission.request]*, not the initial
/// status: a fresh request can resolve straight to `permanentlyDenied` when the
/// user taps "Don't allow".
///
/// UI-light by design — this gate only decides; the dialog owns its look.
/// Callers should gate the permission *before* touching the protected resource
/// (e.g. before creating a camera controller) and bail out when it returns
/// `false`. The [deniedTitle] / [deniedMessage] supply the dialog copy so each
/// permission can explain itself.
Future<bool> ensurePermission(
  BuildContext context,
  Permission permission, {
  required String deniedTitle,
  required String deniedMessage,
}) async {
  var status = await permission.status;

  if (status.isGranted || status.isLimited) return true;

  // Not yet permanently blocked → ask the user once.
  if (status.isDenied) {
    status = await permission.request();
    if (status.isGranted || status.isLimited) return true;
  }

  if (status.isPermanentlyDenied || status.isRestricted) {
    if (!context.mounted) return false;
    final openSettings = await AppDialog.show(
      context,
      title: deniedTitle,
      message: deniedMessage,
      icon: Icons.lock_outline_rounded,
      confirmLabel: context.coreL10n.openSettings,
      cancelLabel: context.coreL10n.cancel,
    );
    if (openSettings) await openAppSettings();
  }
  return false;
}
