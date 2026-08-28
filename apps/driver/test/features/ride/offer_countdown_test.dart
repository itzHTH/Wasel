import 'package:driver/features/ride/ui/providers/ride_controller/offer_countdown.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('counts the window down a second at a time', () {
    fakeAsync((async) {
      final ticks = <int>[];
      final countdown = OfferCountdown(onTick: ticks.add, onExpire: () {});

      countdown.start(3);
      async.elapse(const Duration(seconds: 2));

      expect(ticks, [2, 1]);
      expect(countdown.secondsLeft, 1);

      countdown.stop();
    });
  });

  test('expires once, and stops ticking after it does', () {
    fakeAsync((async) {
      var expired = 0;
      final ticks = <int>[];
      final countdown = OfferCountdown(
        onTick: ticks.add,
        onExpire: () => expired++,
      );

      countdown.start(2);
      async.elapse(const Duration(seconds: 10));

      expect(expired, 1);
      expect(ticks, [1]);
      expect(countdown.isRunning, isFalse);
    });
  });

  test('a stopped window never expires', () {
    fakeAsync((async) {
      var expired = 0;
      final countdown = OfferCountdown(
        onTick: (_) {},
        onExpire: () => expired++,
      );

      countdown.start(5);
      async.elapse(const Duration(seconds: 2));
      countdown.stop();
      async.elapse(const Duration(seconds: 10));

      expect(expired, 0);
    });
  });

  test('resumes from what was left rather than the full window', () {
    fakeAsync((async) {
      final ticks = <int>[];
      final countdown = OfferCountdown(onTick: ticks.add, onExpire: () {});

      countdown.start(30);
      async.elapse(const Duration(seconds: 5));
      final paused = countdown.secondsLeft;
      countdown.stop();

      countdown.start(paused);
      async.elapse(const Duration(seconds: 1));

      expect(paused, 25);
      expect(ticks.last, 24);

      countdown.stop();
    });
  });

  test('restarting drops the window already running', () {
    fakeAsync((async) {
      final ticks = <int>[];
      final countdown = OfferCountdown(onTick: ticks.add, onExpire: () {});

      countdown.start(30);
      async.elapse(const Duration(seconds: 1));
      countdown.start(10);
      async.elapse(const Duration(seconds: 1));

      expect(ticks, [29, 9]);

      countdown.stop();
    });
  });

  test('a window with nothing left expires without ticking', () {
    fakeAsync((async) {
      var expired = 0;
      final ticks = <int>[];
      final countdown = OfferCountdown(
        onTick: ticks.add,
        onExpire: () => expired++,
      );

      countdown.start(0);
      async.elapse(const Duration(seconds: 5));

      expect(expired, 1);
      expect(ticks, isEmpty);
      expect(countdown.isRunning, isFalse);
    });
  });
}
