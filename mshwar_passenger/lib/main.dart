/// 🚀 مشوار — نقطة البداية

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';
import 'features/auth/presentation/screens/splash_screen.dart';

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

  runApp(const MshwarApp());
}

class MshwarApp extends StatelessWidget {
  const MshwarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeNotifier.themeMode,
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'مشوار',
          debugShowCheckedModeBanner: false,

          // ✅ الثيمات
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: currentMode,

          // ✅ RTL عبر localizationsDelegates
          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home: const SplashScreen(),
          
          builder: (context, child) {
            // ✅ تعطيل تأثير المطاط (Overscroll Stretch) المزعج
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
    return child; // إرجاع العنصر بدون أي تأثير (لا Stretch ولا Glow)
  }
}
