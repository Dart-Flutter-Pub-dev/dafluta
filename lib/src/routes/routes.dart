import 'package:flutter/widgets.dart';

class Routes {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  final RouteObserver<ModalRoute<dynamic>> routeObserver =
      RouteObserver<ModalRoute<dynamic>>();

  void subscribe(RouteAware routeAware, BuildContext context) =>
      routeObserver.subscribe(routeAware, ModalRoute.of(context)!);

  void unsubscribe(RouteAware routeAware) =>
      routeObserver.unsubscribe(routeAware);

  Route<dynamic>? current() {
    Route<dynamic>? result;

    popUntil((Route<dynamic> route) {
      result = route;
      return true;
    });

    return result;
  }

  void pop<T>([T? result]) => key.currentState?.pop(result);

  void popUntil(RoutePredicate predicate) =>
      key.currentState?.popUntil(predicate);

  void popUntilName(String routeName) => key.currentState
      ?.popUntil((Route<dynamic> route) => route.settings.name == routeName);

  Future<T?>? push<T>(Route<T> route) => key.currentState?.push(route);

  Future<T?>? pushReplacement<T>(Route<T> route) =>
      key.currentState?.pushReplacement(route);

  Future<T?>? pushAndRemoveUntil<T>(
    Route<T> newRoute,
    RoutePredicate predicate,
  ) =>
      key.currentState?.pushAndRemoveUntil(newRoute, predicate);

  Future<T?>? pushAndRemoveUntilName<T>(
    Route<T> newRoute,
    String routeName,
  ) =>
      key.currentState?.pushAndRemoveUntil(
        newRoute,
        (Route<dynamic> route) => route.settings.name == routeName,
      );

  Future<T?>? pushAlone<T>(Route<T> newRoute) =>
      pushAndRemoveUntil(newRoute, (Route<dynamic> route) => false);
}
