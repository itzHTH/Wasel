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
import 'package:driver/features/driver_verification/ui/screens/under_review_screen.dart';
import 'package:driver/features/driver_verification/ui/screens/verification_wizard_screen.dart';
import 'package:driver/features/driver_verification/ui/widgets/common/verification_status_badge.dart';

class VerificationGateScreen extends ConsumerStatefulWidget {
  const VerificationGateScreen({super.key});

  @override
  ConsumerState<VerificationGateScreen> createState() =>
      _VerificationGateScreenState();
}

class _VerificationGateScreenState
    extends ConsumerState<VerificationGateScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() => ref.read(verifyStatusProvider.notifier).getVerifyStatus();

  void _routeFor(enVerificationStatus? status) {
    switch (status) {
      case null:
      case enVerificationStatus.pending:
      case enVerificationStatus.rejected:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => VerificationWizardScreen(
              rejectionReason: status == enVerificationStatus.rejected
                  ? 'تم رفض معلوماتك ، يرجى مراجعة بياناتك وإعادة الإرسال.'
                  : null,
            ),
          ),
        );
      case enVerificationStatus.underReview:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const UnderReviewScreen()),
        );
      case enVerificationStatus.approved:
        context.pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Route once a resolved status arrives; listen does not fire for the
    // provider's initial null state, so no premature navigation.
    ref.listen(verifyStatusProvider, (_, next) {
      next.whenOrNull(data: (status) => _routeFor(status?.status));
    });

    final state = ref.watch(verifyStatusProvider);
    return Scaffold(
      backgroundColor: AppColor.neutral0,
      body: SafeArea(
        child: Center(
          child: state.when(
            loading: () => const _GateLoader(),
            data: (_) => const _GateLoader(),
            error: (_, __) => _GateError(onRetry: _check),
          ),
        ),
      ),
    );
  }
}

class _GateLoader extends StatelessWidget {
  const _GateLoader();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(color: AppColor.primary500),
        SizedBox(height: AppDimens.space24),
        Text(
          'جارٍ التحقق من حسابك وبعض المعلومات …',
          style: AppTextStyles.font14Neutral400Regular,
        ),
      ],
    );
  }
}

class _GateError extends StatelessWidget {
  final VoidCallback onRetry;

  const _GateError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const VerificationStatusBadge(
            icon: Icons.error_outline_rounded,
            color: AppColor.alertError500,
            background: AppColor.alertError100,
          ),
          SizedBox(height: AppDimens.space24),
          Text(
            'تعذّر التحقق من حالة طلبك',
            style: AppTextStyles.font20Secondary900Bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space8),
          Text(
            'تحقق من اتصالك بالإنترنت ثم أعد المحاولة.',
            style: AppTextStyles.font14Neutral400Regular,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.space32),
          AuthPrimaryButton(label: 'إعادة المحاولة', onPressed: onRetry),
        ],
      ),
    );
  }
}
