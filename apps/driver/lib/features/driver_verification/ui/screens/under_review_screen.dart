import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:flutter/material.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/driver_verification/ui/providers/verify_status/verify_status_provider.dart';
import 'package:driver/features/driver_verification/ui/screens/verification_wizard_screen.dart';
import 'package:driver/features/driver_verification/ui/widgets/common/verification_status_badge.dart';

class UnderReviewScreen extends ConsumerWidget {
  const UnderReviewScreen({super.key});

  Future<void> _refresh(WidgetRef ref) =>
      ref.read(verifyStatusProvider.notifier).getVerifyStatus();

  void _routeFor(BuildContext context, enVerificationStatus status) {
    switch (status) {
      case enVerificationStatus.approved:
        context.pushNamedAndRemoveUntil(AppRoutes.ride);
      case enVerificationStatus.rejected:
        _goToWizard(context, reason: context.l10n.previousRequestRejected);
      case enVerificationStatus.pending:
        _goToWizard(context);
      case enVerificationStatus.underReview:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.stillUnderReview)));
    }
  }

  void _goToWizard(BuildContext context, {String? reason}) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => VerificationWizardScreen(rejectionReason: reason),
      ),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Re-route only when a refresh resolves; the initial state does not fire.
    ref.listen(verifyStatusProvider, (_, next) {
      next.whenOrNull(
        data: (status) => _routeFor(
          context,
          status?.status ?? enVerificationStatus.underReview,
        ),
        error: (_, __) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.statusUpdateFailed)),
        ),
      );
    });

    return Scaffold(
      backgroundColor: context.colors.neutral0,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refresh(ref),
          color: context.colors.primary500,
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimens.screenHPadding,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VerificationStatusBadge(
                        icon: Icons.hourglass_top_rounded,
                        color: context.colors.alertInfo500,
                        background: context.colors.alertInfo100,
                      ),
                      SizedBox(height: AppDimens.space24),
                      Text(
                        context.l10n.requestUnderReview,
                        style: context.styles.title(),
                      ),
                      SizedBox(height: AppDimens.space8),
                      Text(
                        context.l10n.reviewingDocuments,
                        style: context.styles.body(
                          color: context.colors.neutral400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
