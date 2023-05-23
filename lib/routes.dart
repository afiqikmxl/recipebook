import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recipebook/views/details/details.dart';
import 'package:recipebook/views/home/home.dart';
import 'package:recipebook/views/main%20menu/main_menu.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MainMenuScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return HomePage(item: (state.extra as Map)['item']);
          },
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: HomePage(item: (state.extra as Map)['item']),
          ),
        ),
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return DetailsPage(
              image: (state.extra as Map)['item'],
              id: (state.extra as Map)['id'],
              type: (state.extra as Map)['type'],
            );
          },
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: DetailsPage(
              image: (state.extra as Map)['item'],
              id: (state.extra as Map)['id'],
              type: (state.extra as Map)['type'],
            ),
          ),
        ),
      ],
    ),
  ],
);

CustomTransitionPage buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
