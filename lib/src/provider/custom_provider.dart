import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StateProvider<T extends BaseProvider> extends StatefulWidget {
  final T provider;
  final Widget Function(BuildContext context, T provider) builder;

  const StateProvider({this.provider, this.builder});

  @override
  _StateProviderState<T> createState() =>
      _StateProviderState<T>(provider, builder);
}

class _StateProviderState<T extends BaseProvider>
    extends State<StateProvider<T>> implements StateObserver {
  final T provider;
  final Widget Function(BuildContext context, T provider) builder;

  _StateProviderState(this.provider, this.builder);

  @override
  void initState() {
    super.initState();
    provider.addListener(this);
  }

  @override
  void dispose() {
    provider.removeListener(this);
    super.dispose();
  }

  @override
  void onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) => builder(context, provider);
}

class StateObserver {
  void onChanged() {}
}

class BaseProvider {
  final ObserverList<StateObserver> listeners =
      ObserverList<StateObserver>();

  bool get hasListeners => listeners.isNotEmpty;

  void addListener(StateObserver listener) => listeners.add(listener);

  void removeListener(StateObserver listener) => listeners.remove(listener);

  void notify() {
    for (StateObserver listener in listeners) {
      listener.onChanged();
    }
  }
}
