import 'package:find_a_spot/collection/collection.dart';
import 'package:find_a_spot/create/create.dart';
import 'package:find_a_spot/map/map.dart';
import 'package:find_a_spot/shell_navigator/screens/shell_navigator_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:go_router/go_router.dart';
import 'theme.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class NatureFinderApp extends StatelessWidget {
  const NatureFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp.router(
        theme: DynamicTheme.fromDynamicScheme(lightColorScheme),
        darkTheme: DynamicTheme.fromDynamicScheme(darkColorScheme, brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        routerConfig: GoRouter(
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
              builder: (context, state) => const CreatePage(),
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
              builder: (context, state) => EmailVerificationScreen(
                actions: [
                  EmailVerifiedAction(() {
                    context.go('/');
                  })
                ],
              ),
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
        ),
      );
    });
  }
}
