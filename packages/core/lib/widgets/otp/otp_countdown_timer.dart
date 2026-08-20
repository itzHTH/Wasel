import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wasel_core/theme/theme_context_extension.dart';

class OtpCountdownTimer extends StatefulWidget {
  final VoidCallback? onExpired;

  /// How long the user waits before resending. Defaults to the register flow's
  /// original 02:39; the reset flow passes a shorter window.
  final Duration duration;

  const OtpCountdownTimer({
    super.key,
    this.onExpired,
    this.duration = const Duration(seconds: 159),
  });

  @override
  State<OtpCountdownTimer> createState() => _OtpCountdownTimerState();
}

class _OtpCountdownTimerState extends State<OtpCountdownTimer> {
  late int _remaining = widget.duration.inSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_remaining == 0) {
        _timer?.cancel();
        widget.onExpired?.call();
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_remaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remaining % 60).toString().padLeft(2, '0');
    return Text(
      '$minutes:$seconds',
      style: context.styles.font14Secondary500Medium,
      textAlign: TextAlign.center,
    );
  }
}
