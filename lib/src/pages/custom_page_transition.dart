library page_transition;

import 'package:flutter/material.dart';

enum PageTransitionType {
  none,
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
}

class CustomPageTransition<T> extends PageRouteBuilder<T> {
  final PageTransitionType type;
  final Widget child;
  final Duration duration;

  CustomPageTransition({
    required this.type,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  }) : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionDuration: duration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              _transitionsBuilder(
            type,
            context,
            animation,
            secondaryAnimation,
            child,
          ),
        );

  static Widget _transitionsBuilder(
    PageTransitionType type,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (type) {
      case PageTransitionType.none:
        return child;

      case PageTransitionType.fade:
        return FadeTransition(opacity: animation, child: child);

      case PageTransitionType.rightToLeft:
        return SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      case PageTransitionType.leftToRight:
        return SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      case PageTransitionType.upToDown:
        return SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      case PageTransitionType.downToUp:
        return SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      default:
        return child;
    }
  }
}

class FadeRoute<T> extends CustomPageTransition<T> {
  FadeRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          type: PageTransitionType.fade,
          child: child,
          duration: duration,
        );
}

class RightLeftRoute<T> extends CustomPageTransition<T> {
  RightLeftRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          type: PageTransitionType.rightToLeft,
          child: child,
          duration: duration,
        );
}

class LeftRightRoute<T> extends CustomPageTransition<T> {
  LeftRightRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          type: PageTransitionType.leftToRight,
          child: child,
          duration: duration,
        );
}

class UpDownRoute<T> extends CustomPageTransition<T> {
  UpDownRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          type: PageTransitionType.upToDown,
          child: child,
          duration: duration,
        );
}

class DownUpRoute<T> extends CustomPageTransition<T> {
  DownUpRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          type: PageTransitionType.downToUp,
          child: child,
          duration: duration,
        );
}
