/// 🚀 مشوار كابتن — نقطة البداية
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';
import 'features/auth/presentation/screens/onboarding_screen.dart';

// Triggering GitHub Actions
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MshwarDriverApp());
}

class MshwarDriverApp extends StatelessWidget {
  const MshwarDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeNotifier.themeMode,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'مشوار كابتن',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: currentMode,

          // ✅ RTL — عربي من اليمين لليسار
          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home: const OnboardingScreen(),

          builder: (context, child) {
            // ✅ تعطيل تأثير المطاط (Overscroll Stretch)
            return ScrollConfiguration(
              behavior: const _NoStretchScrollBehavior(),
              child: child!,
            );
          },
        );
      },
    );
  }
}

/// سلوك تمرير مخصص لإزالة المطاطية والظلال عند نهاية القوائم
class _NoStretchScrollBehavior extends ScrollBehavior {
  const _NoStretchScrollBehavior();
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
