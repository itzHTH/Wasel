import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

/// A highlight sweeping across content that has to stay readable while it is
/// busy
class AppShimmerSheen extends StatefulWidget {
  const AppShimmerSheen({
    super.key,
    required this.child,
    this.enabled = true,
    this.borderRadius,
    this.highlight,
  });

  final Widget child;
  final bool enabled;

  /// Clips the sweep to the child's own shape.
  final BorderRadius? borderRadius;

  final Color? highlight;

  @override
  State<AppShimmerSheen> createState() => _AppShimmerSheenState();
}

class _AppShimmerSheenState extends State<AppShimmerSheen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sweep;

  @override
  void initState() {
    super.initState();
    _sweep = AnimationController(vsync: this, duration: _period);
    if (widget.enabled) _sweep.repeat();
  }

  @override
  void didUpdateWidget(AppShimmerSheen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled == oldWidget.enabled) return;
    // Idle when there is nothing to report, so a static button costs no frames.
    widget.enabled ? _sweep.repeat() : _sweep.stop();
  }

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    final highlight = widget.highlight ?? context.colors.onPrimary;

    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.zero,
      child: Stack(
        children: [
          widget.child,
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _sweep,
                builder: (context, _) => Align(
                  // Runs from fully off one edge to fully off the other.
                  alignment: Alignment(-2 + 4 * _sweep.value, 0),
                  child: FractionallySizedBox(
                    widthFactor: _bandWidth,
                    heightFactor: 1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            highlight.withValues(alpha: 0),
                            highlight.withValues(alpha: _peakAlpha),
                            highlight.withValues(alpha: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Matched to [AppSkeleton]'s shimmer so the two read as one effect.
const _period = Duration(milliseconds: 1400);

/// Fraction of the width the highlight band covers.
const _bandWidth = 0.35;

const _peakAlpha = 0.32;
