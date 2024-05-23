import 'package:flutter/material.dart';

class DynamicTheme {
  static const Color _fallbackColor = Colors.green;

  static ThemeData fromDynamicScheme(ColorScheme? dynamicScheme, {Brightness brightness = Brightness.light}) {
    ColorScheme colorScheme = dynamicScheme ?? ColorScheme.fromSeed(seedColor: _fallbackColor, brightness: brightness);
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      navigationBarTheme: NavigationBarThemeData(
        surfaceTintColor: colorScheme.surfaceTint,
        backgroundColor: colorScheme.surfaceContainer,
      ),
    );
  }
}
