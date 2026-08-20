import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/providers/theme_mode_provider.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// A three-segment Light / Dark / System control with a thumb that slides
/// between segments.
class AppThemeModeSwitch extends ConsumerWidget {
  const AppThemeModeSwitch({super.key});

  static const _modes = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
  static const _duration = Duration(milliseconds: 280);
  static const _curve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final selected = ref.watch(themeModeControllerProvider);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final duration = reduceMotion ? Duration.zero : _duration;

    // -1 / 0 / 1 along the track, mirrored under RTL so the thumb tracks the
    // segment the reader actually sees.
    final index = _modes.indexOf(selected);
    final ltr = Directionality.of(context) == TextDirection.ltr;
    final x = (index * 2 / (_modes.length - 1)) - 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        final trackPadding = AppDimens.space4;
        final segmentWidth =
            (constraints.maxWidth - trackPadding * 2) / _modes.length;

        // The track is explicitly sized: a bare Stack in a min-height Column
        // leaves the sliding thumb with unbounded height.
        final trackHeight = AppDimens.buttonHeight - trackPadding * 2;

        return Container(
          padding: EdgeInsets.all(trackPadding),
          decoration: BoxDecoration(
            color: colors.neutral100,
            borderRadius: BorderRadius.circular(AppDimens.radiusPill),
            border: Border.all(color: colors.neutral200),
          ),
          child: SizedBox(
            height: trackHeight,
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: duration,
                  curve: _curve,
                  alignment: Alignment(ltr ? x : -x, 0),
                  child: AnimatedContainer(
                    duration: duration,
                    curve: _curve,
                    width: segmentWidth,
                    height: trackHeight,
                    decoration: BoxDecoration(
                      color: colors.primary500,
                      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (final mode in _modes)
                      Expanded(
                        child: _Segment(
                          mode: mode,
                          isSelected: mode == selected,
                          height: trackHeight,
                          duration: duration,
                          onTap: () {
                            if (mode == selected) return;
                            HapticFeedback.selectionClick();
                            unawaited(
                              ref
                                  .read(themeModeControllerProvider.notifier)
                                  .setMode(mode),
                            );
                          },
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

class _Segment extends StatelessWidget {
  const _Segment({
    required this.mode,
    required this.isSelected,
    required this.height,
    required this.duration,
    required this.onTap,
  });

  final ThemeMode mode;
  final bool isSelected;
  final double height;
  final Duration duration;
  final VoidCallback onTap;

  static const _labels = {
    ThemeMode.light: 'فاتح',
    ThemeMode.dark: 'داكن',
    ThemeMode.system: 'النظام',
  };

  static const _icons = {
    ThemeMode.light: Icons.light_mode_rounded,
    ThemeMode.dark: Icons.dark_mode_rounded,
    ThemeMode.system: Icons.brightness_auto_rounded,
  };

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = isSelected ? colors.onPrimary : colors.neutral600;

    return Semantics(
      button: true,
      selected: isSelected,
      label: _labels[mode],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: duration,
                child: Icon(
                  _icons[mode],
                  key: ValueKey(isSelected),
                  size: AppDimens.icon18,
                  color: foreground,
                ),
              ),
              SizedBox(width: AppDimens.space4),
              Flexible(
                child: AnimatedDefaultTextStyle(
                  duration: duration,
                  style: context.styles.font14Secondary900SemiBold.copyWith(
                    color: foreground,
                  ),
                  child: Text(
                    _labels[mode]!,
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
