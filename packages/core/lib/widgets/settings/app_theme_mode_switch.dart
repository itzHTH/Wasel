import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/l10n/core_l10n_extension.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/providers/theme_mode_provider.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

const _orderedModes = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];

const _modeIcons = {
  ThemeMode.light: Icons.light_mode_rounded,
  ThemeMode.dark: Icons.dark_mode_rounded,
  ThemeMode.system: Icons.brightness_auto_rounded,
};

const _slideDuration = Duration(milliseconds: 280);
const _slideCurve = Curves.easeOutCubic;

/// A three-segment Light / Dark / System control with a thumb that slides
/// between segments.
class AppThemeModeSwitch extends ConsumerWidget {
  const AppThemeModeSwitch({super.key});

  void _selectMode(WidgetRef ref, ThemeMode mode) {
    HapticFeedback.selectionClick();
    unawaited(ref.read(themeModeControllerProvider.notifier).setMode(mode));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final selectedMode = ref.watch(themeModeControllerProvider);
    final motionDuration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : _slideDuration;

    return LayoutBuilder(
      builder: (context, constraints) {
        final trackInset = AppDimens.space4;
        final segmentWidth =
            (constraints.maxWidth - trackInset * 2) / _orderedModes.length;

        // Sized explicitly: a bare Stack inside a min-height Column leaves the
        // sliding thumb with unbounded height.
        final segmentHeight = AppDimens.buttonHeight - trackInset * 2;

        return Container(
          padding: EdgeInsets.all(trackInset),
          decoration: BoxDecoration(
            color: colors.neutral100,
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
            border: Border.all(color: colors.neutral200),
          ),
          child: SizedBox(
            height: segmentHeight,
            child: Stack(
              children: [
                _SlidingThumb(
                  selectedMode: selectedMode,
                  width: segmentWidth,
                  height: segmentHeight,
                  motionDuration: motionDuration,
                ),
                Row(
                  children: [
                    for (final mode in _orderedModes)
                      Expanded(
                        child: _ModeSegment(
                          mode: mode,
                          isSelected: mode == selectedMode,
                          height: segmentHeight,
                          motionDuration: motionDuration,
                          onTap: mode == selectedMode
                              ? null
                              : () => _selectMode(ref, mode),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// The filled pill that travels to the selected segment.
class _SlidingThumb extends StatelessWidget {
  const _SlidingThumb({
    required this.selectedMode,
    required this.width,
    required this.height,
    required this.motionDuration,
  });

  final ThemeMode selectedMode;
  final double width;
  final double height;
  final Duration motionDuration;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _orderedModes.indexOf(selectedMode);

    // -1 / 0 / 1 along the track, mirrored under RTL so the thumb lands on the
    // segment the reader actually sees.
    final trackPosition = (selectedIndex * 2 / (_orderedModes.length - 1)) - 1;
    final isLtr = Directionality.of(context) == TextDirection.ltr;

    return AnimatedAlign(
      duration: motionDuration,
      curve: _slideCurve,
      alignment: Alignment(isLtr ? trackPosition : -trackPosition, 0),
      child: AnimatedContainer(
        duration: motionDuration,
        curve: _slideCurve,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: context.colors.primary500,
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        ),
      ),
    );
  }
}

/// One tappable segment. [onTap] is null for the selected mode, which also
/// suppresses the ripple on a segment that has nothing to do.
class _ModeSegment extends StatelessWidget {
  const _ModeSegment({
    required this.mode,
    required this.isSelected,
    required this.height,
    required this.motionDuration,
    required this.onTap,
  });

  final ThemeMode mode;
  final bool isSelected;
  final double height;
  final Duration motionDuration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foregroundColor = isSelected ? colors.onPrimary : colors.neutral600;
    final label = switch (mode) {
      ThemeMode.light => context.coreL10n.themeLight,
      ThemeMode.dark => context.coreL10n.themeDark,
      ThemeMode.system => context.coreL10n.themeSystem,
    };

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: motionDuration,
                child: Icon(
                  _modeIcons[mode],
                  key: ValueKey(isSelected),
                  size: AppDimens.icon18,
                  color: foregroundColor,
                ),
              ),
              SizedBox(width: AppDimens.space4),
              Flexible(
                child: AnimatedDefaultTextStyle(
                  duration: motionDuration,
                  style: context.styles
                      .body(weight: FontWeight.w600)
                      .copyWith(color: foregroundColor),
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
