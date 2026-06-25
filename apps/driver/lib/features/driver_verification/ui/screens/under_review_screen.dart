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

class UnderReviewScreen extends StatefulWidget {
  const UnderReviewScreen({super.key});

  @override
  State<UnderReviewScreen> createState() => _UnderReviewScreenState();
}

class _UnderReviewScreenState extends State<UnderReviewScreen> {
  final _refreshing = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _refreshing.dispose();
    super.dispose();
  }

  Future<void> _checkStatus() async {
    if (_refreshing.value) return;
    _refreshing.value = true;
    final status = await _pollStatus();
    if (!mounted) return;
    _refreshing.value = false;
    _routeFor(status);
  }

  // TODO(provider): replace with the status-poll use case result.
  Future<VerificationStatus> _pollStatus() async =>
      VerificationStatus.underReview;

  void _routeFor(VerificationStatus status) {
    switch (status) {
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
        child: RefreshIndicator(
          onRefresh: _checkStatus,
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
                      ValueListenableBuilder<bool>(
                        valueListenable: _refreshing,
                        builder: (context, refreshing, _) => AuthPrimaryButton(
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
    );
  }
}
