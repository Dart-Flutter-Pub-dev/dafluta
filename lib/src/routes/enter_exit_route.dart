import 'package:flutter/material.dart';

class EnterExitRoute<T> extends PageRouteBuilder<T> {
  final Widget enterPage;
  final Widget exitPage;

  EnterExitRoute({this.exitPage, this.enterPage})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              enterPage,
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0),
                  end: const Offset(-1, 0),
                ).animate(animation),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: const Offset(0, 0),
                  ).animate(secondaryAnimation),
                  child: child,
                ),
              ),
        );
}
