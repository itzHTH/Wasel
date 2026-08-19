import 'package:flutter/material.dart';

class RideHistoryLoadMoreSentinel extends StatefulWidget {
  const RideHistoryLoadMoreSentinel({
    super.key,
    required this.onReached,
    required this.child,
  });

  final VoidCallback onReached;
  final Widget child;

  @override
  State<RideHistoryLoadMoreSentinel> createState() =>
      _RideHistoryLoadMoreSentinelState();
}

class _RideHistoryLoadMoreSentinelState
    extends State<RideHistoryLoadMoreSentinel> {
  @override
  void initState() {
    super.initState();
    // Deferred: the callback mutates a provider, which must not happen while
    // this frame is still building.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onReached();
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
