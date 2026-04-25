/// 👤 شاشة حساب السائق والتقييم — Gumroad Style
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

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
              child: Text('حسابي', style: AppTypography.displayLarge(tp))
                  .animate()
                  .fade(duration: 400.ms)
                  .slideY(begin: -0.2, end: 0, curve: Curves.easeOutBack),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  // بطاقة التقييم
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: border, width: AppDimens.borderThick),
                      boxShadow: [BoxShadow(color: border, offset: const Offset(8, 8))],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 80, height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.info,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: const Icon(Icons.person_rounded, size: 48, color: Colors.black),
                        ),
                        const SizedBox(height: 16),
                        Text('محمود أحمد', style: AppTypography.displayLarge(tp)),
                        Text('تويوتا كامري • ABC 123', style: AppTypography.titleMedium(ts)),
                        
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatBox('التقييم', '4.9', Icons.star_rounded, AppColors.warning, border),
                            _buildStatBox('القبول', '95%', Icons.check_circle_rounded, AppColors.success, border),
                            _buildStatBox('الإلغاء', '2%', Icons.cancel_rounded, AppColors.error, border),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  Text('الإعدادات', style: AppTypography.titleLarge(tp)),
                  const SizedBox(height: 16),
                  
                  _buildSettingsItem('البيانات الشخصية والسيارة', Icons.badge_rounded, border, surface, tp),
                  _buildSettingsItem('المستندات والرخص', Icons.folder_shared_rounded, border, surface, tp),
                  _buildSettingsItem('الدعم الفني', Icons.help_outline_rounded, border, surface, tp),
                  
                  const SizedBox(height: 48),
                  
                  MshwarCardButton(
                    onTap: () {},
                    backgroundColor: AppColors.error,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout_rounded, color: Colors.black),
                        const SizedBox(width: 8),
                        Text('تسجيل الخروج', style: AppTypography.titleLarge(Colors.black)),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon, Color color, Color border) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Icon(icon, color: Colors.black, size: 28),
        ),
        const SizedBox(height: 8),
        Text(value, style: AppTypography.displayLarge(border).copyWith(fontSize: 24)),
        Text(label, style: AppTypography.bodySmall(border.withOpacity(0.7))),
      ],
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, Color border, Color surface, Color tp) {
    return MshwarCardButton(
      onTap: () {},
      backgroundColor: surface,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: tp),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: AppTypography.titleLarge(tp))),
          Icon(Icons.arrow_forward_ios_rounded, color: tp, size: 16),
        ],
      ),
    );
  }
}
