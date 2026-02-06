import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/app/splash_screen.dart';
import '/components/routing/route_error.dart';
import '/presentation/auth/screens/signin_screen.dart';
import '/presentation/home/screens/home_screen.dart';
import '/utils/constants/k_routes.dart';
import 'dialog_service.dart';

final routingService = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    navigatorKey: ref.read(dialogServiceProvider).navigationKey,
    observers: [
      KNavigatorObserver(),
    ],
    routes: <RouteBase>[
      GoRoute(
        name: KRoutes.splashScreen,
        path: '/',
        builder: (context, state) {
          log("parameters :${state.pathParameters} :: Extra: ${state.extra}",
              name: "GoRouter - Splash");
          return const SplashScreen();
        },
      ),
      GoRoute(
        name: KRoutes.signInScreen,
        path: KRoutes.signInScreen,
        pageBuilder: (context, state) {
          log("parameters :${state.pathParameters} :: Extra: ${state.extra}",
              name: "GoRouter - Auth");
          return CustomTransitionPage(
            key: state.pageKey,
            child: SignInScreen(),
            name: KRoutes.signInScreen,
            barrierDismissible: false,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 0,
                  child: child,
                ),
              );
            },
          );
        },
      ),
      GoRoute(
        name: KRoutes.homeScreen,
        path: KRoutes.homeScreen,
        pageBuilder: (context, state) {
          log("parameters :${state.pathParameters} :: Extra: ${state.extra}",
              name: "GoRouter - Home");
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            name: KRoutes.homeScreen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: 0,
                  child: child,
                ),
              );
            },
          );
        },
      ),
      /* GoRoute(
        name: KRoutes.guestListingScreen,
        path: KRoutes.guestListingScreen,
        pageBuilder: (context, state) {
          // String det = state.extra as String;
          log("parameters :${state.pathParameters} :: Extra: ${state.extra}",
              name: "GoRouter - GuestsListingScreen");
          return CustomTransitionPage(
            key: state.pageKey,
            child: const GuestsListingScreen(),
            name: KRoutes.guestListingScreen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return RoutingTransition(
                animation: animation,
                child: child,
              );
            },
          );
        },
      ), */
      /* GoRoute(
        name: KRoutes.guestDetailsScreen,
        path: KRoutes.guestDetailsScreen,
        pageBuilder: (context, state) {
          // String det = state.extra as String;
          log("parameters :${state.pathParameters} :: Extra: ${state.extra}",
              name: "GoRouter - GuestsDetailsScreen");
          return CustomTransitionPage(
            key: state.pageKey,
            child: GuestsDetailsScreen(
              previousguest: state.extra as GuestsModel?,
            ),
            name: KRoutes.guestDetailsScreen,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return RoutingTransition(
                animation: animation,
                child: child,
              );
            },
          );
        },
      ), */
    ],
    errorBuilder: (context, state) {
      log("widget: ${context.widget} -- error: ${state.error} ",
          name: "GoRouter - Error");
      return const RouteError();
    },
  );
});

class KNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // log('${route.currentResult}', name: "Did Push Route");
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // log('${route.currentResult}', name: "Did Pop Route");
  }
}
