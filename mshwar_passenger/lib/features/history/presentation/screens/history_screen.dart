/// 📜 شاشة النشاط (History) — Gumroad Style (Neo-brutalism) + Animation

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'ride_details_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

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
              child: Text('النشاط', style: AppTypography.displayLarge(tp))
                  .animate()
                  .fade(duration: 400.ms)
                  .slideY(begin: -0.2, end: 0, curve: Curves.easeOutBack),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 120), // Padding سفلي لحماية العناصر من الشريط العائم
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MshwarCardButton(
                    onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const RideDetailsScreen())),
                    backgroundColor: surface,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الترويسة (التاريخ والسعر)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('١٢ أبريل • ١٠:٣٠ صباحاً', style: AppTypography.bodySmall(ts)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.warning,
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: Text('١٥٠٠ ر.ي', style: AppTypography.labelLarge(Colors.black)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // المسار (من - إلى)
                        Row(
                          children: [
                            // عمود النقاط والخط
                            Column(
                              children: [
                                Container(
                                  width: 12, height: 12,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    border: Border.all(color: Colors.black, width: 2),
                                  ),
                                ),
                                Container(width: 2, height: 32, color: ts.withOpacity(0.5)),
                                Container(
                                  width: 12, height: 12,
                                  color: border,
                                ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            // عمود العناوين
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('خورمكسر، شارع مدرم', style: AppTypography.titleMedium(tp)),
                                  const SizedBox(height: 24),
                                  Text('كريتر، عدن مول', style: AppTypography.titleMedium(tp)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fade(delay: (50 * index).ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack, delay: (50 * index).ms);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
