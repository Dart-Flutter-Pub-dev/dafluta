import 'package:flutter/material.dart';

class LifecycleWatcher extends StatefulWidget {
  final Widget child;
  final Function(AppLifecycleState) onChange;

  const LifecycleWatcher({
    required this.child,
    required this.onChange,
  });

  @override
  State<LifecycleWatcher> createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState appState) =>
      widget.onChange(appState);

  @override
  Widget build(BuildContext context) => widget.child;
}
