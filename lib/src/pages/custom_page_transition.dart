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

class RightLeftSlideRoute<T> extends CustomPageTransition<T> {
  RightLeftSlideRoute(
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
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          duration: duration,
          name: name,
        );
}

class LeftRightSlideRoute<T> extends CustomPageTransition<T> {
  LeftRightSlideRoute(
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
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          duration: duration,
          name: name,
        );
}

class UpDownSlideRoute<T> extends CustomPageTransition<T> {
  UpDownSlideRoute(
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
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          duration: duration,
          name: name,
        );
}

class DownUpSlideRoute<T> extends CustomPageTransition<T> {
  DownUpSlideRoute(
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
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
          duration: duration,
          name: name,
        );
}

class RightLeftPushRoute<T> extends CustomPageTransition<T> {
  RightLeftPushRoute(
    Widget childNew,
    Widget childCurrent, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: childNew,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(-1, 0),
                ).animate(animation),
                child: childCurrent,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              )
            ],
          ),
          duration: duration,
          name: name,
        );
}

class LeftRightPushRoute<T> extends CustomPageTransition<T> {
  LeftRightPushRoute(
    Widget childNew,
    Widget childCurrent, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: childNew,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(1, 0),
                ).animate(animation),
                child: childCurrent,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              )
            ],
          ),
          duration: duration,
          name: name,
        );
}

class UpDownPushRoute<T> extends CustomPageTransition<T> {
  UpDownPushRoute(
    Widget childNew,
    Widget childCurrent, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: childNew,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(0, 1),
                ).animate(animation),
                child: childCurrent,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              )
            ],
          ),
          duration: duration,
          name: name,
        );
}

class DownUpPushRoute<T> extends CustomPageTransition<T> {
  DownUpPushRoute(
    Widget childNew,
    Widget childCurrent, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
  }) : super(
          child: childNew,
          transition: (
            BuildContext context,
            Animation<double> animation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset.zero,
                  end: const Offset(0, -1),
                ).animate(animation),
                child: childCurrent,
              ),
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              )
            ],
          ),
          duration: duration,
          name: name,
        );
}

class PopRoute<T> extends CustomPageTransition<T> {
  PopRoute(
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
              ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
          duration: duration,
          name: name,
        );
}
