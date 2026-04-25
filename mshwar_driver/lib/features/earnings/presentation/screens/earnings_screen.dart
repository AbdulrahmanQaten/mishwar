/// 💰 شاشة الأرباح (السائق) — Gumroad Style
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg  = isDark ? AppColors.darkBg   : AppColors.lightBg;
    final tp  = isDark ? AppColors.darkTextPrimary   : AppColors.lightTextPrimary;
    final ts  = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? Colors.white : Colors.black;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text('الأرباح', style: AppTypography.displayLarge(tp))
                  .animate()
                  .fade(duration: 400.ms)
                  .slideY(begin: -0.2, end: 0, curve: Curves.easeOutBack),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // بطاقة الرصيد بستايل Receipt
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(8, 8))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('أرباح اليوم', style: AppTypography.titleLarge(Colors.black54)),
                            const Icon(Icons.receipt_long_rounded, color: Colors.black),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('14,500 ر.ي', style: AppTypography.displayLarge(Colors.black).copyWith(fontSize: 48)),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('الرحلات', style: AppTypography.titleMedium(Colors.black54)),
                                  Text('12', style: AppTypography.titleLarge(Colors.black)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ساعات العمل', style: AppTypography.titleMedium(Colors.black54)),
                                  Text('6 س 30 د', style: AppTypography.titleLarge(Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  Text('النشاط الأخير', style: AppTypography.titleLarge(tp)),
                  const SizedBox(height: 16),
                  
                  ...List.generate(5, (index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: AppDimens.r8,
                        border: Border.all(color: border, width: AppDimens.borderThick),
                        boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: const Icon(Icons.check_rounded, color: Colors.black),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('رحلة إلى كريتر', style: AppTypography.titleLarge(tp)),
                                Text('اليوم، 10:30 صباحاً', style: AppTypography.bodySmall(ts)),
                              ],
                            ),
                          ),
                          Text('+1200', style: AppTypography.titleLarge(AppColors.primary).copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ).animate().fade(delay: (100 * index).ms).slideX(begin: 0.2, end: 0);
                  }),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
