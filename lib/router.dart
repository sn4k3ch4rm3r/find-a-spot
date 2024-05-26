import 'package:find_a_spot/features/features.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: FirebaseAuth.instance.currentUser != null ? '/' : '/sign-in',
    routes: [
      StatefulShellRoute.indexedStack(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const CollectionPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/map',
                builder: (context, state) => const MapPage(),
              ),
            ],
          )
        ],
        builder: (context, state, child) => ShellNavigatorPage(state: state, child: child),
      ),
      GoRoute(
        path: '/create',
        builder: (context, state) => CreatePage(image: state.extra as ImageProvider<Object>),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (contex, state) => SignInScreen(
          providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              context.go('/');
            }),
            AuthStateChangeAction<UserCreated>((context, state) {
              context.go('/verify-email');
            })
          ],
        ),
      ),
      GoRoute(
        path: '/verify-email',
        builder: (context, state) {
          return EmailVerificationScreen(
            actions: [
              AuthCancelledAction((context) {
                context.go('/sign-in');
              }),
              EmailVerifiedAction(() {
                context.go('/');
              })
            ],
          );
        },
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(
          providers: FirebaseUIAuth.providersFor(FirebaseAuth.instance.app),
          actions: [
            SignedOutAction((context) {
              context.go('/sign-in');
            }),
          ],
        ),
      ),
    ],
  );
}
