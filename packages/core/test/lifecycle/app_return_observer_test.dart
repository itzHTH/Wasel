import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasel_core/lifecycle/app_return_observer.dart';

void main() {
  late TestWidgetsFlutterBinding binding;

  setUp(() => binding = TestWidgetsFlutterBinding.ensureInitialized());

  void send(AppLifecycleState state) =>
      binding.handleAppLifecycleStateChanged(state);

  test('runs on the way back, not on the way up', () {
    var returns = 0;
    final dispose = observeAppReturn(() => returns++);
    addTearDown(() => dispose?.call());

    send(AppLifecycleState.resumed);
    expect(returns, 0, reason: 'the app coming up is not a return');

    send(AppLifecycleState.paused);
    send(AppLifecycleState.resumed);
    expect(returns, 1);
  });

  test('ignores the inactive flicker of a notification shade', () {
    var returns = 0;
    final dispose = observeAppReturn(() => returns++);
    addTearDown(() => dispose?.call());

    send(AppLifecycleState.inactive);
    send(AppLifecycleState.resumed);

    expect(returns, 0);
  });

  test('counts a hidden app as away', () {
    var returns = 0;
    final dispose = observeAppReturn(() => returns++);
    addTearDown(() => dispose?.call());

    send(AppLifecycleState.hidden);
    send(AppLifecycleState.resumed);

    expect(returns, 1);
  });

  test('goes quiet once disposed', () {
    var returns = 0;
    observeAppReturn(() => returns++)!();

    send(AppLifecycleState.paused);
    send(AppLifecycleState.resumed);

    expect(returns, 0);
  });
}
