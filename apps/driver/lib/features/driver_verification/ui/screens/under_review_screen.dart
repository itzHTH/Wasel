import 'package:driver/features/driver_verification/domain/entities/verification_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';
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
        context.pushNamedAndRemoveUntil(AppRoutes.home);
      case enVerificationStatus.rejected:
        _goToWizard(
          context,
          reason: 'تم رفض طلبك السابق، يرجى مراجعة بياناتك وإعادة الإرسال.',
        );
      case enVerificationStatus.pending:
        _goToWizard(context);
      case enVerificationStatus.underReview:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'لا يزال طلبك قيد المراجعة، سنخبرك فور تحديث الحالة.',
            ),
          ),
        );
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
          const SnackBar(content: Text('تعذّر تحديث الحالة، حاول مجدداً.')),
        ),
      );
    });

    final isLoading = ref.watch(verifyStatusProvider).isLoading;
    return Scaffold(
      backgroundColor: AppColor.neutral0,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => _refresh(ref),
          color: AppColor.primary500,
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
                      const VerificationStatusBadge(
                        icon: Icons.hourglass_top_rounded,
                        color: AppColor.alertInfo500,
                        background: AppColor.alertInfo100,
                      ),
                      SizedBox(height: AppDimens.space24),
                      Text(
                        'طلبك قيد المراجعة',
                        style: AppTextStyles.font20Secondary900Bold,
                      ),
                      SizedBox(height: AppDimens.space8),
                      Text(
                        'نقوم بمراجعة مستنداتك، وعادةً ما يستغرق ذلك حتى ٢٤ ساعة.',
                        style: AppTextStyles.font14Neutral400Regular,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimens.space32),
                      AuthPrimaryButton(
                        label: 'تحديث الحالة',
                        isLoading: isLoading,
                        onPressed: () => _refresh(ref),
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
