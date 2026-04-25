/// ⚙️ شاشة الإعدادات — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/theme_notifier.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import 'personal_info_screen.dart';
import 'security_screen.dart';
import 'notifications_screen.dart';
import '../../../../core/routes/mshwar_page_route.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg  = isDark ? AppColors.darkBg   : AppColors.lightBg;
    final tp  = isDark ? AppColors.darkTextPrimary   : AppColors.lightTextPrimary;
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
                  Expanded(child: Text('الإعدادات', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildSectionTitle('الحساب', tp),
                  _buildSettingItem(Icons.person_outline_rounded, 'المعلومات الشخصية', tp, border, surface, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const PersonalInfoScreen()))),
                  _buildSettingItem(Icons.security_rounded, 'الأمان وكلمة المرور', tp, border, surface, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const SecurityScreen()))),
                  
                  const SizedBox(height: 32),
                  
                  _buildSectionTitle('التطبيق', tp),
                  _buildSettingItem(Icons.notifications_none_rounded, 'الإشعارات', tp, border, surface, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const NotificationsScreen()))),
                  _buildSettingItem(Icons.language_rounded, 'اللغة (العربية)', tp, border, surface),
                  
                  ValueListenableBuilder<ThemeMode>(
                    valueListenable: ThemeNotifier.themeMode,
                    builder: (context, mode, child) {
                      final isDarkMode = mode == ThemeMode.dark || (mode == ThemeMode.system && Theme.of(context).brightness == Brightness.dark);
                      return _buildSettingItem(
                        Icons.dark_mode_outlined, 
                        'المظهر الداكن', 
                        tp, border, surface, 
                        trailing: Switch(
                          value: isDarkMode, 
                          onChanged: (v) => ThemeNotifier.toggle(), 
                          activeColor: AppColors.primary,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color tp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(title, style: AppTypography.titleLarge(tp).copyWith(color: AppColors.primary)),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, Color tp, Color border, Color surface, {Widget? trailing, VoidCallback? onTap}) {
    return MshwarCardButton(
      onTap: onTap ?? () {},
      backgroundColor: surface,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: tp, size: 24),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: AppTypography.titleMedium(tp))),
          trailing ?? Icon(Icons.arrow_forward_ios_rounded, color: tp, size: 16),
        ],
      ),
    );
  }
}
