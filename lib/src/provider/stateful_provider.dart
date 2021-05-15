import 'package:dafluta/src/provider/state_provider.dart';
import 'package:flutter/material.dart';

abstract class StatefulProvider<T extends BaseState> extends StatefulWidget {
  final T state;

  const StatefulProvider(this.state);

  @override
  StateProviderState<T> createState() => StateProviderState<T>(state, builder);

  Widget builder(BuildContext context, T state);
}
