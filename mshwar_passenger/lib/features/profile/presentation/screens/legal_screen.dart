/// ⚖️ المعلومات القانونية — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

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
                  Expanded(child: Text('المعلومات القانونية', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildLegalItem('شروط الاستخدام', isDark, tp, border, surface),
                  _buildLegalItem('سياسة الخصوصية', isDark, tp, border, surface),
                  _buildLegalItem('تراخيص البرمجيات المفتوحة', isDark, tp, border, surface),
                  
                  const SizedBox(height: 48),
                  
                  Center(
                    child: Column(
                      children: [
                        Text('مشوار v1.0.0', style: AppTypography.titleLarge(tp)),
                        const SizedBox(height: 8),
                        Text('جميع الحقوق محفوظة © ٢٠٢٦', style: AppTypography.bodySmall(ts)),
                      ],
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

  Widget _buildLegalItem(String title, bool isDark, Color tp, Color border, Color surface) {
    return MshwarCardButton(
      onTap: () {},
      backgroundColor: surface,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(title, style: AppTypography.titleLarge(tp))),
          Icon(Icons.arrow_forward_ios_rounded, color: tp, size: 16),
        ],
      ),
    );
  }
}
