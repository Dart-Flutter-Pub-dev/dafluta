import 'package:flutter/material.dart';

class SimpleList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext, int, T) builder;

  const SimpleList({
    required this.items,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          for (int i = 0; i < items.length; i++) builder(context, i, items[i]),
        ],
      ),
    );
  }
}
