import 'package:flutter/foundation.dart' show ValueListenable;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasel_core/theme/app_color.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/app_text_styles.dart';
import 'package:driver/features/auth/ui/widgets/common/auth_primary_button.dart';
import 'package:driver/features/driver_verification/ui/models/verification_submission.dart';
import 'package:driver/features/driver_verification/ui/widgets/common/verification_status_badge.dart';

enum _UploadPhase { uploading, success, failure }

class UploadingScreen extends StatefulWidget {
  final VerificationSubmission submission;

  const UploadingScreen({super.key, required this.submission});

  @override
  State<UploadingScreen> createState() => _UploadingScreenState();
}

class _UploadingScreenState extends State<UploadingScreen> {
  final _phase = ValueNotifier<_UploadPhase>(_UploadPhase.uploading);
  final _progress = ValueNotifier<double>(0);

  @override
  void initState() {
    super.initState();
    _startUpload();
  }

  @override
  void dispose() {
    _phase.dispose();
    _progress.dispose();
    super.dispose();
  }

  // TODO(provider): submit widget.submission via the submit use case and drive
  // _progress / _phase from its upload-progress stream — on completion set
  // _phase = success and route to UnderReviewScreen; on error set
  // _phase = failure.
  void _startUpload() {
    _progress.value = 0;
    _phase.value = _UploadPhase.uploading;
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
            padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
            child: Center(
              child: ValueListenableBuilder<_UploadPhase>(
                valueListenable: _phase,
                builder: (context, phase, _) => switch (phase) {
                  _UploadPhase.uploading => _UploadingBody(progress: _progress),
                  _UploadPhase.success => const _SuccessBody(),
                  _UploadPhase.failure => _FailureBody(
                    onRetry: _startUpload,
                    onBackToForm: () => Navigator.of(context).pop(),
                  ),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
        Text(
          'تم رفع المستندات بنجاح',
          style: AppTextStyles.font20Secondary900Bold,
        ),
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
        Text(
          'تعذّر رفع المستندات',
          style: AppTextStyles.font20Secondary900Bold,
        ),
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
