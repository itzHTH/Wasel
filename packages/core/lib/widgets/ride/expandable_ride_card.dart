import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wasel_core/theme/app_dimens.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';
import 'package:wasel_core/widgets/ride/ride_card_shell.dart';

class ExpandableRideCard extends StatefulWidget {
  const ExpandableRideCard({
    super.key,
    required this.summary,
    required this.details,
    this.isMapMoving = false,
    this.footer,
    this.initiallyExpanded = false,
  });

  final Widget summary;
  final Widget details;

  /// True while the map is being panned. The card collapses on the rising edge
  /// so the gesture is not fighting it; each app feeds in its own signal.
  final bool isMapMoving;
  final Widget? footer;
  final bool initiallyExpanded;

  @override
  State<ExpandableRideCard> createState() => _ExpandableRideCardState();
}

class _ExpandableRideCardState extends State<ExpandableRideCard>
    with SingleTickerProviderStateMixin {
  static const _flingVelocity = 300.0;

  static const _peekDelay = Duration(milliseconds: 340);

  static const _peekHold = Duration(milliseconds: 2400);

  late final AnimationController _reveal = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
    value: widget.initiallyExpanded ? 1 : 0,
  );

  final _detailsKey = GlobalKey();

  Timer? _peek;

  @override
  void initState() {
    super.initState();

    if (!widget.initiallyExpanded) _startPeek();
  }

  void _startPeek() {
    _peek = Timer(_peekDelay, () {
      if (!mounted) return;
      _reveal.fling(velocity: 2);
      _peek = Timer(_peekHold, () {
        if (!mounted) return;
        _reveal.fling(velocity: -2);
      });
    });
  }

  void _cancelPeek() {
    _peek?.cancel();
    _peek = null;
  }

  double get _detailsHeight {
    final box = _detailsKey.currentContext?.findRenderObject() as RenderBox?;
    final height = box?.size.height ?? 0;
    return height <= 0 ? 1 : height;
  }

  @override
  void dispose() {
    _peek?.cancel();
    _reveal.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    _cancelPeek();
    _reveal.value -= (details.primaryDelta ?? 0) / _detailsHeight;
  }

  void _onDragEnd(DragEndDetails details) {
    _cancelPeek();
    final velocity = details.primaryVelocity ?? 0;
    final shouldOpen = velocity.abs() > _flingVelocity
        ? velocity < 0
        : _reveal.value >= 0.5;
    _reveal.fling(velocity: shouldOpen ? 2 : -2);
  }

  void _collapseOnMapMove() {
    if (_reveal.value == 0) return;
    _cancelPeek();
    _reveal.fling(velocity: -2);
  }

  @override
  void didUpdateWidget(ExpandableRideCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isMapMoving && widget.isMapMoving) _collapseOnMapMove();
  }

  @override
  Widget build(BuildContext context) {
    final footer = widget.footer;

    return GestureDetector(
      onVerticalDragUpdate: _onDragUpdate,
      onVerticalDragEnd: _onDragEnd,

      behavior: HitTestBehavior.opaque,
      child: RideCardShell(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Grabber(),
            SizedBox(height: AppDimens.space16),
            widget.summary,
            AnimatedBuilder(
              animation: _reveal,
              builder: (context, child) => ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _reveal.value,
                  child: Opacity(opacity: _reveal.value, child: child),
                ),
              ),
              child: Padding(
                key: _detailsKey,
                padding: EdgeInsets.only(top: AppDimens.space16),
                child: widget.details,
              ),
            ),
            if (footer != null) ...[
              SizedBox(height: AppDimens.space24),
              footer,
            ],
          ],
        ),
      ),
    );
  }
}

class _Grabber extends StatelessWidget {
  const _Grabber();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: AppDimens.space40,
        height: AppDimens.space4,
        decoration: BoxDecoration(
          color: context.colors.neutral200,
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
        ),
      ),
    );
  }
}
