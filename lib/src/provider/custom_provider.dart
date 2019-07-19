import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomProvider<T extends ProviderListener> extends StatefulWidget {
  final T provider;
  final Widget Function(BuildContext context, T provider) builder;

  const CustomProvider({this.provider, this.builder});

  @override
  _CustomProviderState<T> createState() =>
      _CustomProviderState<T>(provider, builder);
}

class _CustomProviderState<T extends ProviderListener>
    extends State<CustomProvider<T>> implements ProviderObserver {
  final T provider;
  final Widget Function(BuildContext context, T provider) builder;

  _CustomProviderState(this.provider, this.builder);

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

class ProviderObserver {
  void onChanged() {}
}

class ProviderListener {
  final ObserverList<ProviderObserver> listeners =
      ObserverList<ProviderObserver>();

  bool get hasListeners => listeners.isNotEmpty;

  void addListener(ProviderObserver listener) => listeners.add(listener);

  void removeListener(ProviderObserver listener) => listeners.remove(listener);

  void notify() {
    for (ProviderObserver listener in listeners) {
      listener.onChanged();
    }
  }
}
