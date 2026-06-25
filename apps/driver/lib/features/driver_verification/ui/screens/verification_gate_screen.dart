import 'package:flutter/material.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/driver_verification/ui/models/verification_status.dart';
import 'package:driver/features/driver_verification/ui/screens/under_review_screen.dart';
import 'package:driver/features/driver_verification/ui/screens/verification_wizard_screen.dart';

class VerificationGateScreen extends StatefulWidget {
  const VerificationGateScreen({super.key});

  @override
  State<VerificationGateScreen> createState() => _VerificationGateScreenState();
}

class _VerificationGateScreenState extends State<VerificationGateScreen> {
  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final status = await _pollStatus();
    if (!mounted) return;
    _routeFor(status);
  }

  // TODO(provider): replace with the status-poll use case result.
  Future<VerificationStatus?> _pollStatus() async => null;

  void _routeFor(VerificationStatus? status) {
    switch (status) {
      case null:
      case VerificationStatus.rejected:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => VerificationWizardScreen(
              rejectionReason: status == VerificationStatus.rejected
                  ? 'تم رفض طلبك السابق، يرجى مراجعة بياناتك وإعادة الإرسال.'
                  : null,
            ),
          ),
        );
      case VerificationStatus.pending:
      case VerificationStatus.underReview:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const UnderReviewScreen()),
        );
      case VerificationStatus.approved:
        context.pushReplacementNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.neutral0,
      body: const SafeArea(child: Center(child: _GateLoader())),
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
          'جارٍ التحقق من حالة طلبك…',
          style: AppTextStyles.font14Neutral400Regular,
        ),
      ],
    );
  }
}
