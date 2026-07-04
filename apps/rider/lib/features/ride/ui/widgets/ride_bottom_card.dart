import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/is_camera_moving_provider.dart';
import 'package:wasal/features/ride/ui/providers/ride_draft/ride_draft_provider.dart';
import 'package:wasel_core/wasel_core.dart';

class RideBottomCard extends StatelessWidget {
  const RideBottomCard({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.fromSTEB(
        AppDimens.screenHPadding,
        AppDimens.space16,
        AppDimens.screenHPadding,
        AppDimens.space24,
      ),
      decoration: BoxDecoration(
        color: AppColor.elementBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimens.radius24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              _BackButton(),
              Expanded(child: _CardTitle()),
            ],
          ),
          const _SummaryText(),
          SizedBox(height: AppDimens.space16),
          _ConfirmButton(onPressed: onConfirm),
        ],
      ),
    );
  }
}

class _CardTitle extends ConsumerWidget {
  const _CardTitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(rideDraftProvider.select((s) => s.cardTitle));
    return Text(title, style: AppTextStyles.font20Secondary900Bold);
  }
}

class _SummaryText extends ConsumerWidget {
  const _SummaryText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(rideDraftProvider.select((s) => s.summaryText));
    if (summary.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsetsDirectional.only(top: AppDimens.space8),
      child: Text(summary, style: AppTextStyles.font14Secondary500Medium),
    );
  }
}

class _ConfirmButton extends ConsumerWidget {
  const _ConfirmButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = ref.watch(
      rideDraftProvider.select((s) => s.confirmButtonLabel),
    );
    final isCameraMoving = ref.watch(isCameraMovingProvider);
    return SizedBox(
      height: AppDimens.buttonHeight,
      child: ElevatedButton(
        onPressed: isCameraMoving ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary500,
          disabledBackgroundColor: AppColor.primary300,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          ),
        ),
        child: Text(label, style: AppTextStyles.font16Neutral0SemiBold),
      ),
    );
  }
}

class _BackButton extends ConsumerWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final show = ref.watch(rideDraftProvider.select((s) => s.showBackButton));
    if (!show) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsetsDirectional.only(end: AppDimens.space8),
      child: IconButton(
        onPressed: () => ref.read(rideDraftProvider.notifier).goBackOneStep(),
        style: IconButton.styleFrom(backgroundColor: AppColor.neutral100),
        icon: const Icon(Icons.arrow_back, color: AppColor.secondary900),
      ),
    );
  }
}
