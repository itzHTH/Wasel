import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wasel_core/localization/app_local_type.dart';
import 'package:wasel_core/localization/providers/app_localization_provider.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

const _orderedLocales = AppLocaleType.values;

const _slideDuration = Duration(milliseconds: 280);
const _slideCurve = Curves.easeOutCubic;

/// A two-segment Arabic / English control with a thumb that slides between
/// segments. Mirrors [AppThemeModeSwitch] in both behaviour and metrics.
class AppLanguageSwitch extends ConsumerWidget {
  const AppLanguageSwitch({super.key});

  void _selectLocale(WidgetRef ref, AppLocaleType type) {
    HapticFeedback.selectionClick();
    unawaited(
      ref
          .read(appLocalizationControllerProvider.notifier)
          .setLocale(Locale(type.code)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final selectedCode = ref
        .watch(appLocalizationControllerProvider)
        .languageCode;
    final selectedLocale = _localeForCode(selectedCode);
    final motionDuration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : _slideDuration;

    return LayoutBuilder(
      builder: (context, constraints) {
        final trackInset = AppDimens.space4;
        final segmentWidth =
            (constraints.maxWidth - trackInset * 2) / _orderedLocales.length;

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
                  selectedLocale: selectedLocale,
                  width: segmentWidth,
                  height: segmentHeight,
                  motionDuration: motionDuration,
                ),
                Row(
                  children: [
                    for (final type in _orderedLocales)
                      Expanded(
                        child: _LocaleSegment(
                          type: type,
                          isSelected: type == selectedLocale,
                          height: segmentHeight,
                          motionDuration: motionDuration,
                          onTap: type == selectedLocale
                              ? null
                              : () => _selectLocale(ref, type),
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

/// Resolves a stored language code back to the vocabulary, falling back to
/// Arabic for anything the app no longer offers.
AppLocaleType _localeForCode(String code) => AppLocaleType.values.firstWhere(
  (type) => type.code == code,
  orElse: () => AppLocaleType.arabic,
);

/// The filled pill that travels to the selected segment.
class _SlidingThumb extends StatelessWidget {
  const _SlidingThumb({
    required this.selectedLocale,
    required this.width,
    required this.height,
    required this.motionDuration,
  });

  final AppLocaleType selectedLocale;
  final double width;
  final double height;
  final Duration motionDuration;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _orderedLocales.indexOf(selectedLocale);

    // -1 / 1 along the track, mirrored under RTL so the thumb lands on the
    // segment the reader actually sees.
    final trackPosition =
        (selectedIndex * 2 / (_orderedLocales.length - 1)) - 1;
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

/// One tappable segment. [onTap] is null for the active language, which also
/// suppresses the ripple on a segment that has nothing to do.
class _LocaleSegment extends StatelessWidget {
  const _LocaleSegment({
    required this.type,
    required this.isSelected,
    required this.height,
    required this.motionDuration,
    required this.onTap,
  });

  final AppLocaleType type;
  final bool isSelected;
  final double height;
  final Duration motionDuration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foregroundColor = isSelected ? colors.onPrimary : colors.neutral600;

    // Each language names itself, so the label stays readable whichever
    // language is currently active.
    final label = type.name;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        child: SizedBox(
          height: height,
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: motionDuration,
              style: context.styles
                  .body(weight: FontWeight.w600)
                  .copyWith(color: foregroundColor),
              child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ),
        ),
      ),
    );
  }
}
