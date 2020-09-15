import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightStatusBar extends StatelessWidget {
  final Widget child;

  const LightStatusBar({@required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: child,
    );
  }
}

class DarkStatusBar extends StatelessWidget {
  final Widget child;

  const DarkStatusBar({@required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: child,
    );
  }
}

class CustomStatusBar extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle style;
  final Color navigationBarColor;
  final Color navigationBarDividerColor;
  final Brightness navigationBarIconBrightness;
  final Color statusBarColor;
  final Brightness statusBarBrightness;
  final Brightness statusBarIconBrightness;

  const CustomStatusBar({
    @required this.child,
    this.style,
    this.navigationBarColor,
    this.navigationBarDividerColor,
    this.navigationBarIconBrightness,
    this.statusBarColor,
    this.statusBarBrightness,
    this.statusBarIconBrightness,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (style != null)
          ? style
          : SystemUiOverlayStyle(
              systemNavigationBarColor: navigationBarColor,
              systemNavigationBarDividerColor: navigationBarDividerColor,
              systemNavigationBarIconBrightness: navigationBarIconBrightness,
              statusBarColor: statusBarColor,
              statusBarBrightness: statusBarBrightness,
              statusBarIconBrightness: statusBarIconBrightness,
            ),
      child: child,
    );
  }
}
