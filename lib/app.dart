import 'package:find_a_spot/common/providers/navigation_provider.dart';
import 'package:find_a_spot/common/widgets/navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';

class NatureFinderApp extends StatelessWidget {
  const NatureFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp(
          theme: DynamicTheme.fromDynamicScheme(lightColorScheme),
          darkTheme: DynamicTheme.fromDynamicScheme(darkColorScheme, brightness: Brightness.dark),
          themeMode: ThemeMode.system,
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          home: const NavigationPage(),
        );
      }),
    );
  }
}
