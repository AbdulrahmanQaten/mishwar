/// 🗺️ شاشة التتبع (Tracking) — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import 'rating_screen.dart';
import 'chat_screen.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tp = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final ts = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final border = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: Stack(
        children: [
          // الخريطة
          Container(color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE5E5E5)),

          // زر العودة
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            child: MshwarCardButton(
  onTap: () => Navigator.pop(context),
  backgroundColor: surface,
  padding: const EdgeInsets.all(8),
  child: Icon(Icons.close_rounded, size: 24, color: tp),
),
          ),

          // لوحة التتبع السفلية
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: AppDimens.bottomSheetRadius,
                border: Border(top: BorderSide(color: border, width: AppDimens.borderThick)),
                boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(0, -4), blurRadius: 0)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 48, height: 6,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white24 : Colors.black12,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('يصل خلال ٣ دقائق', style: AppTypography.displayLarge(tp)),
                          Text('تويوتا كامري - أبيض', style: AppTypography.titleMedium(ts)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          border: Border.all(color: Colors.black, width: 2),
                          boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(2, 2))],
                        ),
                        child: Text('١٢٣٤ ص ي', style: AppTypography.titleLarge(Colors.black)),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),

                  // بيانات السائق
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkBg : AppColors.lightBg,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: border, width: AppDimens.borderThick),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 56, height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.info,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: const Icon(Icons.person_rounded, size: 32, color: Colors.black),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('محمد أحمد', style: AppTypography.titleLarge(tp)),
                              Row(
                                children: [
                                  Icon(Icons.star_rounded, color: AppColors.warning, size: 16),
                                  const SizedBox(width: 4),
                                  Text('4.9', style: AppTypography.bodySmall(tp)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // أزرار الاتصال
                        Row(
                          children: [
                            _buildActionBtn(Icons.chat_bubble_rounded, AppColors.warning, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const ChatScreen()))),
                            const SizedBox(width: 12),
                            _buildActionBtn(Icons.phone_rounded, AppColors.success),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // زر إنهاء مؤقت (للتجربة)
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MshwarPageRoute(builder: (_) => const RatingScreen()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: AppDimens.r8,
                        border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
                      ),
                      child: Center(
                        child: Text('إنهاء الرحلة (للتجربة)', style: AppTypography.titleLarge(Colors.black)),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ).animate().slideY(begin: 1.0, end: 0, duration: 400.ms, curve: Curves.easeOutBack),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(IconData icon, Color bg, {VoidCallback? onTap}) {
    return MshwarCardButton(
      onTap: onTap ?? () {},
      backgroundColor: bg,
      isCircle: true,
      padding: const EdgeInsets.all(12),
      child: Icon(icon, color: Colors.black, size: 24),
    );
  }
}
