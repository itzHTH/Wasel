import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:wasel_core/extensions/navigation_extension.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/core/routing/app_routes_name.dart';
import 'package:driver/features/driver_verification/ui/models/verification_status.dart';
import 'package:driver/features/driver_verification/ui/screens/under_review_screen.dart';
import 'package:driver/features/driver_verification/ui/screens/verification_wizard_screen.dart';

/// Entry point for driver verification. Shows a loader while "checking" the
/// driver's status, then routes by the 4-state model:
/// no-status / [VerificationStatus.rejected] → wizard,
/// [VerificationStatus.pending] / [VerificationStatus.underReview] → review,
/// [VerificationStatus.approved] → home.
///
/// UI-only: the status check is faked. A fresh driver has no status yet, so the
/// release default routes to the wizard. In debug a selector lets QA pick any
/// status so every branch is testable. The `// TODO(provider)` seam marks where
/// the status-poll use case plugs in.
class VerificationGateScreen extends StatefulWidget {
  const VerificationGateScreen({super.key});

  @override
  State<VerificationGateScreen> createState() => _VerificationGateScreenState();
}

class _VerificationGateScreenState extends State<VerificationGateScreen> {
  // A freshly-registered driver has no status yet → wizard.
  static const VerificationStatus? _fakeStatus = null;

  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _check();
  }

  // TODO(provider): replace the fake delay + status with the status-poll use
  // case, then route on its result.
  Future<void> _check() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    // In debug, hand control to the selector instead of auto-routing so all
    // branches can be exercised without recompiling.
    if (kDebugMode) {
      setState(() => _checking = false);
      return;
    }
    _routeFor(_fakeStatus);
  }

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
      body: SafeArea(
        child: Center(
          child: _checking
              ? const _GateLoader()
              : _DebugStatusPicker(onPick: _routeFor),
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
          'جارٍ التحقق من حالة طلبك…',
          style: AppTextStyles.font14Neutral400Regular,
        ),
      ],
    );
  }
}

/// Debug-only entry-status picker so QA can land on any branch. Never shown in
/// release builds (the gate auto-routes there).
class _DebugStatusPicker extends StatelessWidget {
  final void Function(VerificationStatus?) onPick;

  const _DebugStatusPicker({required this.onPick});

  static const _options = <(VerificationStatus?, String)>[
    (null, 'لا يوجد طلب (للنموذج)'),
    (VerificationStatus.underReview, 'قيد المراجعة'),
    (VerificationStatus.approved, 'مقبول'),
    (VerificationStatus.rejected, 'مرفوض'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'محاكاة حالة الدخول (debug)',
            style: AppTextStyles.font14Secondary900SemiBold,
          ),
          SizedBox(height: AppDimens.space16),
          for (final (status, label) in _options)
            Padding(
              padding: EdgeInsets.only(bottom: AppDimens.space8),
              child: OutlinedButton(
                onPressed: () => onPick(status),
                child: Text(label),
              ),
            ),
        ],
      ),
    );
  }
}
