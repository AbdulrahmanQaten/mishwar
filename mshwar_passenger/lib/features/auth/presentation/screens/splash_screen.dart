/// 🚀 شاشة البداية (Splash)
/// تتحقق من حالة التطبيق وتوجه المستخدم

import 'package:flutter/material.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../home/presentation/screens/main_screen.dart';
import 'onboarding_screen.dart';
import 'phone_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _fade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));

    _ctrl.forward();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('is_first_launch') ?? true;
    
    // محاكاة تسجيل الدخول (للآن سنذهب دائماً للهاتف ما لم يكن أول تشغيل)
    // لاحقاً سنفحص الـ Token للتوجه لـ MainScreen مباشرة

    Widget nextScreen;
    if (isFirstLaunch) {
      await prefs.setBool('is_first_launch', false);
      nextScreen = const OnboardingScreen();
    } else {
      nextScreen = const PhoneScreen();
    }

    Navigator.of(context).pushReplacement(
      MshwarPageRoute(builder: (_) => nextScreen),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBg : AppColors.lightBg;
    final tp = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Text(
            'مشوار',
            style: AppTypography.displayLarge(tp).copyWith(fontSize: 48),
          ),
        ),
      ),
    );
  }
}
