import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wasal/core/theme/app_text_styles.dart';

class OtpCountdownTimer extends StatefulWidget {
  final VoidCallback? onExpired;

  const OtpCountdownTimer({super.key, this.onExpired});

  @override
  State<OtpCountdownTimer> createState() => _OtpCountdownTimerState();
}

class _OtpCountdownTimerState extends State<OtpCountdownTimer> {
  static const _initialSeconds = 159; // 02:39
  int _remaining = _initialSeconds;
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
      style: AppTextStyles.font14Secondary500Medium,
      textAlign: TextAlign.center,
    );
  }
}
