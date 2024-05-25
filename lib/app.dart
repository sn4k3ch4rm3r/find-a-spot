import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:go_router/go_router.dart';
import 'theme.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class NatureFinderApp extends StatelessWidget {
  final GoRouter router;
  const NatureFinderApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      return MaterialApp.router(
        theme: DynamicTheme.fromDynamicScheme(lightColorScheme),
        darkTheme: DynamicTheme.fromDynamicScheme(darkColorScheme, brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        routerConfig: router,
      );
    });
  }
}
