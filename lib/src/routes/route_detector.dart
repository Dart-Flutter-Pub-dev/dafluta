import 'package:flutter/material.dart';

class RouteDetector extends StatefulWidget {
  final Widget child;
  final Function(RouteAware, BuildContext) subscribe;
  final Function(RouteAware) unsubscribe;
  final VoidCallback? didPopNext;
  final VoidCallback? didPush;
  final VoidCallback? didPop;
  final VoidCallback? didPushNext;

  const RouteDetector({
    required this.child,
    required this.subscribe,
    required this.unsubscribe,
    this.didPopNext,
    this.didPush,
    this.didPop,
    this.didPushNext,
  });

  @override
  State<RouteDetector> createState() => _RouteDetectorState();
}

class _RouteDetectorState extends State<RouteDetector> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.subscribe(this, context);
  }

  @override
  void dispose() {
    widget.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() => widget.didPopNext?.call();

  @override
  void didPush() => widget.didPush?.call();

  @override
  void didPop() => widget.didPop?.call();

  @override
  void didPushNext() => widget.didPushNext?.call();

  @override
  Widget build(BuildContext context) => widget.child;
}
