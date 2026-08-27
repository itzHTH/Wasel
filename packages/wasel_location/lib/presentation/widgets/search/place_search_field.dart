import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/widgets/feedback/app_skeleton.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_location/l10n/location_l10n_extension.dart';

/// One row of the search header: an endpoint marker, a text field, and a
/// trailing affordance that becomes a spinner while the query is in flight.
///
/// Draws no border of its own — the header groups both fields into a single
/// card, so focus reads as a change of fill rather than a competing outline.
///
/// The [controller] and [focusNode] are owned by the hosting screen's State —
/// never built here, so a rebuild cannot drop the user's cursor.
class PlaceSearchField extends StatelessWidget {
  const PlaceSearchField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.marker,
    required this.onChanged,
    required this.onSubmitted,
    required this.onCleared,
    this.isBusy = false,
    this.textInputAction = TextInputAction.search,
    this.readOnly = false,
    this.onBlockedTap,
    this.isResolvingLabel = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;

  /// The dot or square tying this field to its marker on the map.
  final Widget marker;

  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onCleared;

  /// Drives the trailing spinner. Deliberately separate from the results
  /// panel, so progress shows here while previous results stay readable.
  final bool isBusy;

  final TextInputAction textInputAction;

  /// Locks the field without greying it out — a disabled-looking destination
  /// row reads as broken, where a locked one that answers a tap reads as
  /// sequenced.
  final bool readOnly;

  /// Called instead of focusing, when [readOnly] swallowed the tap.
  final VoidCallback? onBlockedTap;

  /// The point is already chosen and its name is still being looked up. Shows
  /// a shimmer in place of the hint, so a slow lookup reads as pending rather
  /// than as an empty field the rider still has to fill.
  final bool isResolvingLabel;

  /// The gutter the markers sit in. The rail joining them is drawn down the
  /// centre of this same width, so dot, line and square share one axis.
  static double get markerGutter => AppDimens.icon24;

  /// Inset of [markerGutter] from the field's leading edge.
  static double get markerInset => AppDimens.space12;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AnimatedBuilder(
      // Rebuilds on focus for the fill, and on text for the clear button.
      animation: Listenable.merge([focusNode, controller]),
      builder: (context, _) {
        final isFocused = focusNode.hasFocus;
        final showLabelShimmer = isResolvingLabel && controller.text.isEmpty;

        final row = AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(horizontal: AppDimens.space12),
          decoration: BoxDecoration(
            color: isFocused
                ? colors.primary500.withValues(alpha: 0.10)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppDimens.radius12),
          ),
          child: Row(
            children: [
              SizedBox(
                width: markerGutter,
                child: Center(child: marker),
              ),
              SizedBox(width: AppDimens.space8),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    TextField(
                      controller: controller,
                      focusNode: focusNode,
                      readOnly: readOnly,
                      onChanged: onChanged,
                      onSubmitted: onSubmitted,
                      textInputAction: textInputAction,
                      keyboardType: TextInputType.text,
                      style: context.styles.body(weight: FontWeight.w600),
                      cursorColor: colors.primary500,
                      decoration: InputDecoration(
                        isDense: true,
                        // The group behind supplies the surface; the theme's own
                        // fill would paint a block over the middle of the row.
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: showLabelShimmer ? '' : hintText,
                        hintStyle: context.styles.bodyMuted(
                          weight: FontWeight.w400,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: AppDimens.space16,
                        ),
                        isCollapsed: false,
                      ),
                    ),
                    // Sits over the hint, and lets taps through so the rider
                    // can still type a different pickup while it resolves.
                    if (showLabelShimmer)
                      IgnorePointer(
                        child: FractionallySizedBox(
                          widthFactor: 0.55,
                          child: AppSkeleton(
                            child: Container(
                              height: AppDimens.space16,
                              decoration: BoxDecoration(
                                color: colors.neutral200,
                                borderRadius: BorderRadius.circular(
                                  AppDimens.radius4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              _Trailing(
                isBusy: isBusy,
                showClear: controller.text.isNotEmpty,
                onCleared: onCleared,
              ),
            ],
          ),
        );

        if (!readOnly) return row;

        // Intercepted above the field rather than through TextField.onTap,
        // which a read-only field fires twice — once per tap would otherwise
        // stack two identical snackbars.
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onBlockedTap,
          child: IgnorePointer(child: row),
        );
      },
    );
  }
}

class _Trailing extends StatelessWidget {
  const _Trailing({
    required this.isBusy,
    required this.showClear,
    required this.onCleared,
  });

  final bool isBusy;
  final bool showClear;
  final VoidCallback onCleared;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 160),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
      child: switch ((isBusy, showClear)) {
        (true, _) => SizedBox(
          key: const ValueKey('busy'),
          width: AppDimens.icon18,
          height: AppDimens.icon18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colors.primary500,
          ),
        ),
        (false, true) => IconButton(
          key: const ValueKey('clear'),
          onPressed: onCleared,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          tooltip: context.locationL10n.clearSearchField,
          icon: Icon(
            Icons.cancel_rounded,
            size: AppDimens.icon20,
            color: colors.neutral400,
          ),
        ),
        (false, false) => const SizedBox(key: ValueKey('idle')),
      },
    );
  }
}

/// The pickup dot and drop-off square, matching the map's own markers.
///
/// The focused endpoint grows a soft ring, so the marker — not just the text —
/// says which leg of the trip is being edited.
///
/// Drop-off takes `onSurface` rather than a palette tone so it inverts with
/// the theme exactly as the map's destination pin does.
class EndpointMarker extends StatelessWidget {
  const EndpointMarker({
    super.key,
    required this.isPickup,
    this.isActive = false,
  });

  final bool isPickup;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final tone = isPickup
        ? colors.primary500
        : Theme.of(context).colorScheme.onSurface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: EdgeInsets.all(isActive ? AppDimens.space4 : 0),
      decoration: BoxDecoration(
        color: isActive ? tone.withValues(alpha: 0.16) : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Container(
        width: AppDimens.icon12,
        height: AppDimens.icon12,
        decoration: BoxDecoration(
          color: tone,
          shape: isPickup ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isPickup
              ? null
              : BorderRadius.circular(AppDimens.radius4),
        ),
      ),
    );
  }
}
