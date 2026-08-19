import 'package:flutter/material.dart';

class AppEntranceFade extends StatefulWidget {
  const AppEntranceFade({
    super.key,
    required this.child,
    this.index = 0,
    this.animate = true,
    this.duration = const Duration(milliseconds: 280),
    this.stagger = const Duration(milliseconds: 40),
    this.beginOffset = const Offset(0, 0.06),
  });

  /// Rows at or past this index skip the stagger delay entirely.
  static const int maxStaggeredIndex = 8;

  final Widget child;
  final int index;
  final bool animate;
  final Duration duration;
  final Duration stagger;
  final Offset beginOffset;

  @override
  State<AppEntranceFade> createState() => _AppEntranceFadeState();
}

class _AppEntranceFadeState extends State<AppEntranceFade>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    if (!widget.animate) {
      _controller = AnimationController(vsync: this, value: 1);
      _animation = _controller;
      return;
    }

    final delay = widget.index < AppEntranceFade.maxStaggeredIndex
        ? widget.stagger * widget.index
        : Duration.zero;
    final total = delay + widget.duration;

    _controller = AnimationController(vsync: this, duration: total)..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        delay.inMicroseconds / total.inMicroseconds,
        1,
        curve: Curves.easeOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: widget.beginOffset,
          end: Offset.zero,
        ).animate(_animation),
        textDirection: Directionality.of(context),
        child: widget.child,
      ),
    );
  }
}
