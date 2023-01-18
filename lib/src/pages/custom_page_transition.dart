library page_transition;

import 'package:flutter/material.dart';

class CustomPageTransition<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Widget Function(BuildContext, Animation<double>, Widget) transition;
  final Duration duration;
  String? name;

  CustomPageTransition({
    required this.child,
    required this.transition,
    this.duration = const Duration(milliseconds: 300),
    this.name,
  }) : super(
          settings: (name != null) ? RouteSettings(name: name) : null,
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
              transition(context, animation, child),
        );
}

class BasicRoute<T> extends CustomPageTransition<T> {
  BasicRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: child,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              child,
          duration: duration,
          name: name,
        );
}

class FadeRoute<T> extends CustomPageTransition<T> {
  FadeRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: child,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          duration: duration,
          name: name,
        );
}

class RightLeftRoute<T> extends CustomPageTransition<T> {
  RightLeftRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: child,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          duration: duration,
          name: name,
        );
}

class LeftRightRoute<T> extends CustomPageTransition<T> {
  LeftRightRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: child,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          duration: duration,
          name: name,
        );
}

class UpDownRoute<T> extends CustomPageTransition<T> {
  UpDownRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: child,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          duration: duration,
          name: name,
        );
}

class DownUpRoute<T> extends CustomPageTransition<T> {
  DownUpRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: child,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              SlideTransition(
            transformHitTests: false,
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          duration: duration,
          name: name,
        );
}
