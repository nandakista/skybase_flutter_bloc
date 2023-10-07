import 'dart:developer';

import 'package:flutter/material.dart';

class AppNavigatorObserver extends NavigatorObserver {
  final String tag = 'AppBlocObserver::->';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    String? routeName = route.settings.name;
    String? prevRouteName = previousRoute?.settings.name;
    log('$tag didPush() {routeName:$routeName, prevRouteName:$prevRouteName}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    String? routeName = route.settings.name;
    String? prevRouteName = previousRoute?.settings.name;

    log('$tag didPop() {routeName:$routeName, prevRouteName:$prevRouteName}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    String? routeName = route.settings.name;
    String? prevRouteName = previousRoute?.settings.name;

    log('$tag didRemove() {routeName:$routeName, prevRouteName:$prevRouteName}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    String? newRouteName = newRoute?.settings.name;
    String? oldRouteName = oldRoute?.settings.name;

    log('$tag didReplace() {newRouteName:$newRouteName, oldRouteName:$oldRouteName}');
  }
}