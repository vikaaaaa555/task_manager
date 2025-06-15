import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/auth/auth_screen_wrapper.dart';
import '../screens/home/home_screen_wrapper.dart';

class AppNavigation {
  static const initial = '/';
  static const home = '/home';

  static final _rootNavigationKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    initialLocation: initial,
    navigatorKey: _rootNavigationKey,
    routes: [
      GoRoute(
        path: initial,
        builder: (context, state) => const AuthScreenWrapper(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreenWrapper(),
      ),
    ],
  );
}