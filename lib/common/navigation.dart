import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentRoute(Route route) {
    navigatorKey.currentState?.push(route);
  }

  static intentNamed(String route) {
    navigatorKey.currentState?.pushNamed(route);
  }

  static intentReplace(String route) {
    navigatorKey.currentState?.pushReplacementNamed(route);
  }

  static intentReplaceWithData(String route, Object arguments) {
    navigatorKey.currentState
        ?.pushReplacementNamed(route, arguments: arguments);
  }

  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static back() {
    navigatorKey.currentState?.pop();
  }
}
