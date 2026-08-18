import 'package:flutter/material.dart';

class AppNavigation {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState get navigator => navigatorKey.currentState!;

  /// Null while no navigator is mounted, e.g. a 401 arriving before the app's
  /// MaterialApp has built.
  static NavigatorState? get maybeNavigator => navigatorKey.currentState;

  static BuildContext get context => navigatorKey.currentContext!;

  static void pushNamed(String routeName, {Object? arguments}) {
    navigator.pushNamed(routeName, arguments: arguments);
  }

  static void pushReplacementNamed(String routeName, {Object? arguments}) {
    navigator.pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    required RoutePredicate predicate,
  }) {
    navigator.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  static void pop() {
    navigator.pop();
  }

  static void popUntil(RoutePredicate predicate) {
    navigator.popUntil(predicate);
  }

  static void push(
    Widget widget, {
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
  }) {
    navigator.push(
      MaterialPageRoute(
        builder: (context) => widget,
        maintainState: maintainState,
        fullscreenDialog: fullscreenDialog,
        allowSnapshotting: allowSnapshotting,
      ),
    );
  }

  static void pushReplacement(Widget widget) {
    navigator.pushReplacement(MaterialPageRoute(builder: (context) => widget));
  }

  static void pushAndRemoveUntil(Widget widget, RoutePredicate predicate) {
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
      predicate,
    );
  }
}
