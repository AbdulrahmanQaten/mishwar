/// 🆘 شاشة المساعدة — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
                  Expanded(child: Text('المساعدة', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text('كيف يمكننا مساعدتك اليوم؟', style: AppTypography.displayLarge(tp)),
                  const SizedBox(height: 8),
                  Text('نحن هنا لضمان حصولك على أفضل تجربة رحلة ممكنة.', style: AppTypography.bodyLarge(ts)),
                  
                  const SizedBox(height: 32),
                  
                  _buildHelpItem(Icons.chat_bubble_outline_rounded, 'تحدث مع الدعم الفني', 'متاح 24/7 للرد على استفساراتك', tp, ts, border, surface),
                  _buildHelpItem(Icons.local_police_outlined, 'الإبلاغ عن مشكلة أمنية', 'للحالات الطارئة ومشاكل السلامة', tp, ts, border, surface),
                  _buildHelpItem(Icons.question_answer_outlined, 'الأسئلة الشائعة', 'تصفح الإجابات السريعة', tp, ts, border, surface),
                  _buildHelpItem(Icons.contact_support_outlined, 'فقدت غرضاً', 'كيفية استرجاع المفقودات من الكابتن', tp, ts, border, surface),
                  
                  const SizedBox(height: 32),
                  
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.phone_in_talk_rounded, size: 48, color: Colors.black),
                        const SizedBox(height: 16),
                        Text('خدمة العملاء', style: AppTypography.titleLarge(Colors.black)),
                        const SizedBox(height: 8),
                        Text('800-MSHWAR', style: AppTypography.displayLarge(Colors.black)),
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

  Widget _buildHelpItem(IconData icon, String title, String subtitle, Color tp, Color ts, Color border, Color surface) {
    return MshwarCardButton(
      onTap: () {},
      backgroundColor: surface,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.info,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Icon(icon, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.titleLarge(tp)),
                Text(subtitle, style: AppTypography.bodySmall(ts)),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: tp, size: 16),
        ],
      ),
    );
  }
}
