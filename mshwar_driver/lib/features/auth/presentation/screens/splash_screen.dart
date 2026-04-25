/// 🚀 شاشة البداية (Splash) السائق — Gumroad Style
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'phone_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MshwarPageRoute(builder: (_) => const PhoneScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 4),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(6, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.local_taxi_rounded, // أيقونة سيارة أجرة للسائق
                size: 64,
                color: Colors.black,
              ),
            )
            .animate()
            .scale(duration: 600.ms, curve: Curves.easeOutBack)
            .then()
            .shake(duration: 400.ms),
            
            const SizedBox(height: 32),
            
            Text(
              'مشوار كابتن',
              style: AppTypography.displayLarge(Colors.black).copyWith(
                fontSize: 48,
                letterSpacing: -1,
              ),
            )
            .animate()
            .fade(delay: 400.ms, duration: 400.ms)
            .slideY(begin: 0.5, end: 0, curve: Curves.easeOutExpo),
            
            const SizedBox(height: 8),
            
            Text(
              'شريك النجاح',
              style: AppTypography.titleLarge(Colors.black87),
            )
            .animate()
            .fade(delay: 600.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
