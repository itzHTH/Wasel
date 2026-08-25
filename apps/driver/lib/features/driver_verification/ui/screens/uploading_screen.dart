import 'package:wasel_auth/wasel_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasel_core/wasel_core.dart';
import 'package:driver/l10n/l10n_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:driver/features/driver_verification/domain/entities/driver_profile_submission.dart';
import 'package:driver/features/driver_verification/ui/providers/submit_profile/submit_profile_provider.dart';
import 'package:driver/features/driver_verification/ui/providers/submit_profile/submit_profile_state.dart';
import 'package:driver/features/driver_verification/ui/screens/under_review_screen.dart';
import 'package:driver/features/driver_verification/ui/widgets/common/verification_status_badge.dart';

class UploadingScreen extends ConsumerStatefulWidget {
  final DriverProfileSubmission submission;

  const UploadingScreen({super.key, required this.submission});

  @override
  ConsumerState<UploadingScreen> createState() => _UploadingScreenState();
}

class _UploadingScreenState extends ConsumerState<UploadingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startUpload());
  }

  void _startUpload() =>
      ref.read(submitProfileProvider.notifier).submit(widget.submission);

  @override
  Widget build(BuildContext context) {
    // On success, move to the review screen; clears the wizard from the stack.
    ref.listen(submitProfileProvider, (_, next) {
      if (next is SubmitSuccess) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const UnderReviewScreen()),
        );
      }
    });

    final state = ref.watch(submitProfileProvider);
    return PopScope(
      // Block the system back gesture; exits go through the explicit buttons.
      canPop: false,
      child: Scaffold(
        backgroundColor: context.colors.neutral0,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.screenHPadding),
            child: Center(
              child: switch (state) {
                SubmitUploading(:final progress) => _UploadingBody(
                  progress: progress,
                ),
                SubmitSuccess() => const _SuccessBody(),
                SubmitFailure(:final message) => _FailureBody(
                  message: message,
                  onRetry: _startUpload,
                  onBackToForm: () => Navigator.of(context).pop(),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _UploadingBody extends StatelessWidget {
  final double progress;

  const _UploadingBody({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 132.r,
          height: 132.r,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: context.colors.neutral100,
                  valueColor: AlwaysStoppedAnimation(context.colors.primary500),
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: context.styles.headline(),
              ),
            ],
          ),
        ),
        SizedBox(height: AppDimens.space24),
        Text(context.l10n.uploadingDocuments, style: context.styles.title()),
        SizedBox(height: AppDimens.space8),
        Text(
          context.l10n.pleaseWaitDontClose,
          style: context.styles.bodyMuted(),
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
        VerificationStatusBadge(
          icon: Icons.check_rounded,
          color: context.colors.alertSuccess500,
          background: context.colors.alertSuccess100,
        ),
        SizedBox(height: AppDimens.space24),
        Text(context.l10n.documentsUploaded, style: context.styles.title()),
        SizedBox(height: AppDimens.space8),
        Text(
          context.l10n.willNotifyResult,
          style: context.styles.bodyMuted(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _FailureBody extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final VoidCallback onBackToForm;

  const _FailureBody({
    required this.message,
    required this.onRetry,
    required this.onBackToForm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VerificationStatusBadge(
          icon: Icons.close_rounded,
          color: context.colors.alertError500,
          background: context.colors.alertError100,
        ),
        SizedBox(height: AppDimens.space24),
        Text(context.l10n.uploadFailed, style: context.styles.title()),
        SizedBox(height: AppDimens.space8),
        Text(
          message,
          style: context.styles.bodyMuted(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimens.space32),
        AuthPrimaryButton(label: context.coreL10n.retry, onPressed: onRetry),
        SizedBox(height: AppDimens.space12),
        TextButton(
          onPressed: onBackToForm,
          child: Text(
            context.l10n.backToForm,
            style: context.styles.body(weight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
