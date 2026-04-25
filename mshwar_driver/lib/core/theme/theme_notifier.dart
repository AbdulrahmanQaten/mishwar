import 'package:flutter/material.dart';

class ThemeNotifier {
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  static void toggle() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
  }
}
