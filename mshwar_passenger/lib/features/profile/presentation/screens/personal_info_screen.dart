/// 👤 المعلومات الشخصية — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../../shared/widgets/mshwar_snackbar.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

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
                  Expanded(child: Text('المعلومات الشخصية', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Center(
                    child: Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
                      ),
                      child: const Icon(Icons.person_rounded, size: 48, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  _buildInputField('الاسم الكامل', 'عبدالرحمن قطن', tp, border, surface),
                  const SizedBox(height: 16),
                  _buildInputField('رقم الهاتف', '777 000 000', tp, border, surface, enabled: false),
                  const SizedBox(height: 16),
                  _buildInputField('البريد الإلكتروني', 'اختياري', tp, border, surface),
                ],
              ),
            ),
            
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              child: MshwarButton(
                label: 'حفظ التغييرات',
                icon: Icons.save_rounded,
                onPressed: () {
                  MshwarSnackbar.show(context: context, message: 'تم تحديث بياناتك!', type: SnackbarType.success);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, Color tp, Color border, Color surface, {bool enabled = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.titleMedium(tp)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: enabled ? surface : (surface == Colors.white ? const Color(0xFFF0F0F0) : const Color(0xFF222222)),
            borderRadius: AppDimens.r8,
            border: Border.all(color: border, width: AppDimens.borderThick),
            boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
          ),
          child: TextField(
            enabled: enabled,
            style: AppTypography.titleLarge(tp),
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
