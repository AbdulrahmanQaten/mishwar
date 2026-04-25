/// 🔔 شاشة الإشعارات — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
                  Expanded(child: Text('الإشعارات', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildNotificationItem('خصم ٥٠٪ على مشوارك القادم!', 'استخدم الكود MSHWAR50', 'الآن', true, AppColors.warning, border, surface, tp, ts),
                  _buildNotificationItem('تمت إضافة الرصيد بنجاح', 'تمت إضافة ١٠٠٠ ر.ي إلى محفظتك', 'منذ ساعتين', false, AppColors.success, border, surface, tp, ts),
                  _buildNotificationItem('تحديث جديد للتطبيق', 'قمنا بإضافة تحسينات مذهلة لتجربة أفضل.', 'أمس', false, AppColors.info, border, surface, tp, ts),
                  _buildNotificationItem('تقييم الكابتن', 'لا تنسَ تقييم رحلتك الأخيرة مع الكابتن محمود.', '١٢ أكتوبر', false, AppColors.primary, border, surface, tp, ts),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String body, String time, bool isNew, Color iconBg, Color border, Color surface, Color tp, Color ts) {
    return MshwarCardButton(
      onTap: () {},
      backgroundColor: isNew ? (surface == AppColors.surfaceDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5)) : surface,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Icon(Icons.notifications_active_rounded, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(title, style: AppTypography.titleLarge(tp))),
                    Text(time, style: AppTypography.labelLarge(ts)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(body, style: AppTypography.bodyMedium(isNew ? tp : ts)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
