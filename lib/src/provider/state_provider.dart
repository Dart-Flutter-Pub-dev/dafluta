import 'package:dafluta/dafluta.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StateProvider<T extends BaseState> extends StatefulWidget {
  final T state;
  final Widget Function(BuildContext, T) builder;

  const StateProvider({
    required this.state,
    required this.builder,
  });

  @override
  StateProviderState<T> createState() => StateProviderState<T>(state, builder);
}

class StateProviderState<T extends BaseState> extends State<StateProvider<T>>
    implements StateObserver {
  final T state;
  final Widget Function(BuildContext, T) builder;

  StateProviderState(this.state, this.builder);

  @override
  void initState() {
    super.initState();
    state.addListener(this);
  }

  @override
  void dispose() {
    state.removeListener(this);
    super.dispose();
  }

  @override
  void onChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => builder(context, state);
}

class StateObserver {
  void onChanged() {}
}

class BaseState {
  final ObserverList<StateObserver> listeners = ObserverList<StateObserver>();

  BaseState() {
    Delayed.post(onLoad);
  }

  bool get hasListeners => listeners.isNotEmpty;

  void onLoad() {}

  void onDestroy() {}

  void addListener(StateObserver listener) => listeners.add(listener);

  void removeListener(StateObserver listener) {
    listeners.remove(listener);

    if (listeners.isEmpty) {
      onDestroy();
    }
  }

  void notify() {
    for (final StateObserver listener in listeners) {
      listener.onChanged();
    }
  }

  void delayedNotify() => Delayed.post(notify);
}
