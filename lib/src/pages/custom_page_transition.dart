library page_transition;

import 'package:flutter/material.dart';

class CustomPageTransition<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Widget Function(BuildContext, Animation<double>, Widget) transition;
  final Duration duration;
  String? name;
  Object? arguments;

  CustomPageTransition({
    required this.child,
    required this.transition,
    this.duration = const Duration(milliseconds: 300),
    this.name,
    this.arguments,
  }) : super(
          settings: (name != null) || (arguments != null)
              ? RouteSettings(
                  name: name,
                  arguments: arguments,
                )
              : null,
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
    Object? arguments,
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
          arguments: arguments,
        );
}

class FadeRoute<T> extends CustomPageTransition<T> {
  FadeRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}

class RightLeftSlideRoute<T> extends CustomPageTransition<T> {
  RightLeftSlideRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}

class LeftRightSlideRoute<T> extends CustomPageTransition<T> {
  LeftRightSlideRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}

class UpDownSlideRoute<T> extends CustomPageTransition<T> {
  UpDownSlideRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}

class DownUpSlideRoute<T> extends CustomPageTransition<T> {
  DownUpSlideRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}

class RightLeftPushRoute<T> extends CustomPageTransition<T> {
  RightLeftPushRoute(
    Widget childNew,
    Widget childCurrent, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}

class LeftRightPushRoute<T> extends CustomPageTransition<T> {
  LeftRightPushRoute(
    Widget childNew,
    Widget childCurrent, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}

class UpDownPushRoute<T> extends CustomPageTransition<T> {
  UpDownPushRoute(
    Widget childNew,
    Widget childCurrent, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}

class DownUpPushRoute<T> extends CustomPageTransition<T> {
  DownUpPushRoute(
    Widget childNew,
    Widget childCurrent, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}

class PopRoute<T> extends CustomPageTransition<T> {
  PopRoute(
    Widget child, {
    Duration duration = const Duration(milliseconds: 300),
    String? name,
    Object? arguments,
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
          arguments: arguments,
        );
}
