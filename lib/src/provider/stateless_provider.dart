import 'package:dafluta/src/provider/state_provider.dart';
import 'package:flutter/material.dart';

abstract class StatelessProvider<T extends BaseState> extends StatelessWidget {
  final T state;

  const StatelessProvider(this.state);

  Widget builder(BuildContext context, T state);

  @override
  Widget build(BuildContext context) =>
      StateProvider<T>(state: state, builder: builder);
}
