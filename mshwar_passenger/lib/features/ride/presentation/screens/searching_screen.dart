/// 🔍 شاشة البحث عن سائق — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import 'tracking_screen.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MshwarPageRoute(builder: (_) => const TrackingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBg : AppColors.lightBg;
    final tp = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final border = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          // الخريطة
          Container(color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE5E5E5)),

          // لوحة جاري البحث العائمة
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).padding.bottom + 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: AppDimens.r8,
                border: Border.all(color: border, width: AppDimens.borderThick),
                boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4), blurRadius: 0)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
                    ),
                    child: const Center(
                      child: Icon(Icons.search_rounded, size: 40, color: Colors.black),
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scaleXY(begin: 1.0, end: 1.1, duration: 800.ms, curve: Curves.easeInOut)
                  .then()
                  .scaleXY(begin: 1.1, end: 1.0, duration: 800.ms, curve: Curves.easeInOut),

                  const SizedBox(height: 32),

                  Text('جاري البحث عن كابتن...', style: AppTypography.displayLarge(tp), textAlign: TextAlign.center),
                  
                  const SizedBox(height: 16),
                  
                  Text('نرسل طلبك لأقرب السائقين في منطقتك', style: AppTypography.bodyLarge(tp), textAlign: TextAlign.center),
                  
                  const SizedBox(height: 32),

                  LinearProgressIndicator(
                    backgroundColor: isDark ? Colors.white24 : Colors.black12,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    minHeight: 8,
                  ),

                  const SizedBox(height: 24),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: AppDimens.r8,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Text('إلغاء الطلب', style: AppTypography.titleLarge(Colors.black)),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().slideY(begin: 1.0, end: 0, duration: 400.ms, curve: Curves.easeOutBack),
          ),
        ],
      ),
    );
  }
}
