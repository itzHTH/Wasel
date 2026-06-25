import 'package:flutter/material.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:driver/features/driver_verification/ui/models/verification_status.dart';
import 'package:driver/features/driver_verification/ui/screens/verification_wizard_screen.dart';
import 'package:driver/features/driver_verification/ui/widgets/common/verification_status_badge.dart';

/// Shown while the submitted verification awaits a back-office decision. Status
/// is **polled** (there is no FCM): the driver pulls-to-refresh or taps "تحديث
/// الحالة", and the result routes them onward.
///
/// UI-only: the status check is faked. In debug a selector picks what the next
/// refresh returns, so all branches (still pending / approved / rejected) are
/// testable. The `// TODO(provider)` seam marks where the status-poll use case
/// plugs in.
class UnderReviewScreen extends StatefulWidget {
  const UnderReviewScreen({super.key});

  @override
  State<UnderReviewScreen> createState() => _UnderReviewScreenState();
}

class _UnderReviewScreenState extends State<UnderReviewScreen> {
  final _refreshing = ValueNotifier<bool>(false);

  /// Debug-only: what the next fake status check resolves to.
  final _simulatedStatus = ValueNotifier<VerificationStatus>(
    VerificationStatus.underReview,
  );

  @override
  void dispose() {
    _refreshing.dispose();
    _simulatedStatus.dispose();
    super.dispose();
  }

  // TODO(provider): replace the fake delay + simulated status with the
  // status-poll use case; route on its result.
  Future<void> _checkStatus() async {
    if (_refreshing.value) return;
    _refreshing.value = true;
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    _refreshing.value = false;

    switch (_simulatedStatus.value) {
      case VerificationStatus.approved:
        context.pushNamedAndRemoveUntil(AppRoutes.home);
      case VerificationStatus.rejected:
        _goToWizardRejected();
      case VerificationStatus.pending:
      case VerificationStatus.underReview:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'لا يزال طلبك قيد المراجعة، سنخبرك فور تحديث الحالة.',
            ),
          ),
        );
    }
  }

  void _goToWizardRejected() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const VerificationWizardScreen(
          rejectionReason:
              'تم رفض طلبك السابق، يرجى مراجعة بياناتك وإعادة الإرسال.',
        ),
      ),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral0,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _checkStatus,
                color: AppColor.primary500,
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
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
                            ValueListenableBuilder<bool>(
                              valueListenable: _refreshing,
                              builder: (context, refreshing, _) =>
                                  AuthPrimaryButton(
                                    label: 'تحديث الحالة',
                                    isLoading: refreshing,
                                    onPressed: _checkStatus,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
