import 'package:flutter/material.dart';

class FadeRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRoute(this.page)
      : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(
                opacity: animation,
                child: child,
              ),
        );
}
