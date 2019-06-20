import 'package:flutter/material.dart';

class EnterExitRoute<T> extends PageRouteBuilder<T> {
  final Widget enterPage;
  final Widget exitPage;

  EnterExitRoute({this.exitPage, this.enterPage})
      : super(
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              Stack(
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0),
                      end: const Offset(-1, 0),
                    ).animate(animation),
                    child: exitPage,
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: enterPage,
                  )
                ],
              ),
        );
}
