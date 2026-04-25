/// 📄 تفاصيل الرحلة — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';

class RideDetailsScreen extends StatelessWidget {
  const RideDetailsScreen({super.key});

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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  MshwarCardButton(
                    onTap: () => Navigator.pop(context),
                    backgroundColor: surface,
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back_rounded, size: 24, color: tp),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Text('تفاصيل الرحلة', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // خريطة مصغرة
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE5E5E5),
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: border, width: AppDimens.borderThick),
                      boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 100, height: 4,
                            color: border.withOpacity(0.2),
                          ),
                        ),
                        const Center(child: Icon(Icons.location_on_rounded, size: 48, color: Colors.black)),
                        Positioned(
                          right: 12, top: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Text('مكتملة', style: AppTypography.labelLarge(Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // تفاصيل الوقت والمبلغ
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailCard('التاريخ', '١٢ أكتوبر', Icons.calendar_today_rounded, AppColors.info, surface, border, tp),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDetailCard('المبلغ', '١٥٠٠ ر.ي', Icons.payments_rounded, AppColors.warning, surface, border, tp),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // المسار
                  Text('المسار', style: AppTypography.titleLarge(tp)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: border, width: AppDimens.borderThick),
                      boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.my_location_rounded, color: Colors.black, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('المنزل', style: AppTypography.titleMedium(tp)),
                                  Text('شارع حدة، صنعاء', style: AppTypography.bodySmall(ts)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 9, top: 8, bottom: 8),
                          width: 2, height: 24,
                          color: border.withOpacity(0.3),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, color: AppColors.primary, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('العمل', style: AppTypography.titleMedium(tp)),
                                  Text('شارع الزبيري، صنعاء', style: AppTypography.bodySmall(ts)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // معلومات الكابتن
                  Text('الكابتن', style: AppTypography.titleLarge(tp)),
                  const SizedBox(height: 12),
                  Container(
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
                          width: 48, height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.info,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: const Icon(Icons.person_rounded, size: 24, color: Colors.black),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('محمود أحمد', style: AppTypography.titleMedium(tp)),
                              Text('تويوتا كامري', style: AppTypography.bodySmall(ts)),
                            ],
                          ),
                        ),
                        Row(
                          children: List.generate(5, (index) => Icon(
                            Icons.star_rounded,
                            color: index < 5 ? AppColors.warning : border.withOpacity(0.2),
                            size: 16,
                          )),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  MshwarCardButton(
                    onTap: () {},
                    backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text('المساعدة بشأن هذه الرحلة', style: AppTypography.titleLarge(AppColors.primary)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String label, String value, IconData icon, Color iconBg, Color surface, Color border, Color tp) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: AppDimens.r8,
        border: Border.all(color: border, width: AppDimens.borderThick),
        boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Icon(icon, color: Colors.black, size: 20),
          ),
          const SizedBox(height: 12),
          Text(label, style: AppTypography.bodySmall(tp.withOpacity(0.7))),
          Text(value, style: AppTypography.titleLarge(tp)),
        ],
      ),
    );
  }
}
