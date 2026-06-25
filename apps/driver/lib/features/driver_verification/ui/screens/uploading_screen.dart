import 'dart:async';

import 'package:flutter/foundation.dart' show ValueListenable, kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:driver/features/driver_verification/ui/models/verification_submission.dart';
import 'package:driver/features/driver_verification/ui/screens/under_review_screen.dart';
import 'package:driver/features/driver_verification/ui/widgets/common/verification_status_badge.dart';

/// The three visible states of the submit/upload flow.
enum _UploadPhase { uploading, success, failure }

/// Submit/upload screen — blocks interaction while the verification documents
/// are "uploaded", then resolves to success or an in-place failure with retry.
///
/// UI-only: progress is driven by a **fake** timer and the outcome by a
/// debug-only failure toggle. The `// TODO(provider)` seams mark where the
/// submit use case + its upload-progress stream plug in later. The captured
/// images live in [VerificationSubmission] for the whole session, so a retry
/// never requires re-capturing.
class UploadingScreen extends StatefulWidget {
  final VerificationSubmission submission;

  const UploadingScreen({super.key, required this.submission});

  @override
  State<UploadingScreen> createState() => _UploadingScreenState();
}

class _UploadingScreenState extends State<UploadingScreen> {
  // Fake upload pacing: ~3s from 0 → 100%.
  static const _tick = Duration(milliseconds: 60);
  static const _step = 0.02;

  final _phase = ValueNotifier<_UploadPhase>(_UploadPhase.uploading);
  final _progress = ValueNotifier<double>(0);

  /// Debug-only: force the next attempt to fail so both paths are testable.
  final _simulateFailure = ValueNotifier<bool>(false);

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startUpload();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _phase.dispose();
    _progress.dispose();
    _simulateFailure.dispose();
    super.dispose();
  }

  /// Runs (or re-runs) the fake upload from zero.
  // TODO(provider): replace the timer with the submit use case + its
  // upload-progress stream; drive [_progress]/[_phase] from that instead.
  void _startUpload() {
    _timer?.cancel();
    _progress.value = 0;
    _phase.value = _UploadPhase.uploading;
    _timer = Timer.periodic(_tick, (timer) {
      final next = _progress.value + _step;
      if (next >= 1) {
        _progress.value = 1;
        timer.cancel();
        _finish();
      } else {
        _progress.value = next;
      }
    });
  }

  void _finish() {
    if (_simulateFailure.value) {
      _phase.value = _UploadPhase.failure;
      return;
    }
    _phase.value = _UploadPhase.success;
    // Brief success confirmation, then route to the Under Review screen.
    // TODO(provider): trigger this once the submit use case reports completion.
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const UnderReviewScreen()),
      );
    });
  }

  void _backToForm() {
    _timer?.cancel();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Block the system back gesture; exits go through the explicit buttons.
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.neutral0,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.screenHPadding,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: ValueListenableBuilder<_UploadPhase>(
                      valueListenable: _phase,
                      builder: (context, phase, _) => switch (phase) {
                        _UploadPhase.uploading => _UploadingBody(
                          progress: _progress,
                        ),
                        _UploadPhase.success => const _SuccessBody(),
                        _UploadPhase.failure => _FailureBody(
                          onRetry: _startUpload,
                          onBackToForm: _backToForm,
                        ),
                      },
                    ),
                  ),
                ),
                if (kDebugMode) _DebugFailureToggle(value: _simulateFailure),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Circular progress ring with the live percentage in the centre.
class _UploadingBody extends StatelessWidget {
  final ValueListenable<double> progress;

  const _UploadingBody({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 132.r,
          height: 132.r,
          child: ValueListenableBuilder<double>(
            valueListenable: progress,
            builder: (context, value, _) => Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: CircularProgressIndicator(
                    value: value,
                    strokeWidth: 6,
                    backgroundColor: AppColor.neutral100,
                    valueColor: const AlwaysStoppedAnimation(
                      AppColor.primary500,
                    ),
                  ),
                ),
                Text(
                  '${(value * 100).round()}%',
                  style: AppTextStyles.font24Secondary900Bold,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: AppDimens.space24),
        Text(
          'جارٍ رفع المستندات…',
          style: AppTextStyles.font20Secondary900Bold,
        ),
        SizedBox(height: AppDimens.space8),
        Text(
          'يرجى الانتظار وعدم إغلاق التطبيق.',
          style: AppTextStyles.font14Neutral400Regular,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Terminal success state. Phase 6 swaps this for navigation to Under Review.
class _SuccessBody extends StatelessWidget {
  const _SuccessBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const VerificationStatusBadge(
          icon: Icons.check_rounded,
          color: AppColor.alertSuccess500,
          background: AppColor.alertSuccess100,
        ),
        SizedBox(height: AppDimens.space24),
        Text('تم رفع المستندات بنجاح', style: AppTextStyles.font20Secondary900Bold),
        SizedBox(height: AppDimens.space8),
        Text(
          'سيتم مراجعة طلبك وإشعارك بالنتيجة.',
          style: AppTextStyles.font14Neutral400Regular,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// In-place failure state: message + retry (re-runs upload, no re-capture) +
/// back to the form.
class _FailureBody extends StatelessWidget {
  final VoidCallback onRetry;
  final VoidCallback onBackToForm;

  const _FailureBody({required this.onRetry, required this.onBackToForm});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const VerificationStatusBadge(
          icon: Icons.close_rounded,
          color: AppColor.alertError500,
          background: AppColor.alertError100,
        ),
        SizedBox(height: AppDimens.space24),
        Text('تعذّر رفع المستندات', style: AppTextStyles.font20Secondary900Bold),
        SizedBox(height: AppDimens.space8),
        Text(
          'تحقق من اتصالك بالإنترنت ثم أعد المحاولة.',
          style: AppTextStyles.font14Neutral400Regular,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimens.space32),
        AuthPrimaryButton(label: 'إعادة المحاولة', onPressed: onRetry),
        SizedBox(height: AppDimens.space12),
        TextButton(
          onPressed: onBackToForm,
          child: Text(
            'العودة للنموذج',
            style: AppTextStyles.font14Secondary900SemiBold,
          ),
        ),
      ],
    );
  }
}

/// Debug-only switch to force the next attempt to fail, so QA can exercise the
/// failure → retry path deterministically. Never shown in release builds.
class _DebugFailureToggle extends StatelessWidget {
  final ValueNotifier<bool> value;

  const _DebugFailureToggle({required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDimens.space8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'محاكاة فشل الرفع (debug)',
            style: AppTextStyles.font12Neutral400Regular,
          ),
          ValueListenableBuilder<bool>(
            valueListenable: value,
            builder: (context, on, _) => Switch(
              value: on,
              activeThumbColor: AppColor.alertError500,
              onChanged: (next) => value.value = next,
            ),
          ),
        ],
      ),
    );
  }
}
