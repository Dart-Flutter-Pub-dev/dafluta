import 'package:flutter/material.dart';

class Unclosable extends StatelessWidget {
  final Widget child;

  const Unclosable({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: child,
    );
  }
}
