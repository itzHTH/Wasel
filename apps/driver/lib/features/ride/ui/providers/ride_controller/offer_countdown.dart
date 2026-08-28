import 'dart:async';

class OfferCountdown {
  OfferCountdown({required this.onTick, required this.onExpire});

  final void Function(int secondsLeft) onTick;
  final void Function() onExpire;

  Timer? _timer;
  int _secondsLeft = 0;

  int get secondsLeft => _secondsLeft;

  bool get isRunning => _timer != null;

  void start(int seconds) {
    stop();

    if (seconds <= 0) {
      onExpire();
      return;
    }

    _secondsLeft = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void _tick() {
    _secondsLeft--;

    if (_secondsLeft <= 0) {
      stop();
      onExpire();
      return;
    }

    onTick(_secondsLeft);
  }
}
