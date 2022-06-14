import 'package:flutter/material.dart';

class RunOnce extends StatefulWidget {
  final VoidCallback function;
  final Widget child;

  const RunOnce({
    required this.function,
    required this.child,
  });

  @override
  State<RunOnce> createState() => _RunOnceState();
}

class _RunOnceState extends State<RunOnce> {
  @override
  void initState() {
    super.initState();
    widget.function();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
