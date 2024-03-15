part of routes;

class RouteObservers<R extends Route<dynamic>> extends RouteObserver<R> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final name = route.settings.name ?? '';
    if (name.isNotEmpty) Routes.history.add(name);
    if (kDebugMode) print('didPush: ${Routes.history}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    Routes.history.remove(route.settings.name);
    if (kDebugMode) print('didPop: ${Routes.history}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      final index = Routes.history.indexWhere((element) {
        return element == oldRoute?.settings.name;
      });
      final name = newRoute.settings.name ?? '';
      if (name.isNotEmpty) {
        if (index > -1) {
          Routes.history[index] = name;
        } else {
          Routes.history.add(name);
        }
      }
    }
    if (kDebugMode) print('didReplace: ${Routes.history}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    Routes.history.remove(route.settings.name);
    if (kDebugMode) print('didRemove: ${Routes.history}');
  }
}
