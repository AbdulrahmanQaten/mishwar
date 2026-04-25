/// 🔒 الأمان وكلمة المرور — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../../shared/widgets/mshwar_snackbar.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

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
                  Expanded(child: Text('الأمان وكلمة المرور', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildInputField('كلمة المرور الحالية', '••••••••', tp, border, surface),
                  const SizedBox(height: 16),
                  _buildInputField('كلمة المرور الجديدة', '••••••••', tp, border, surface),
                  const SizedBox(height: 16),
                  _buildInputField('تأكيد كلمة المرور', '••••••••', tp, border, surface),
                  
                  const SizedBox(height: 48),
                  
                  Text('إدارة الحساب', style: AppTypography.titleLarge(AppColors.error)),
                  const SizedBox(height: 12),
                  MshwarCardButton(
                    onTap: () {},
                    backgroundColor: AppColors.error,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('حذف الحساب نهائياً', style: AppTypography.titleMedium(Colors.black)),
                        const Icon(Icons.delete_outline_rounded, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              child: MshwarButton(
                label: 'تحديث كلمة المرور',
                icon: Icons.lock_reset_rounded,
                onPressed: () {
                  MshwarSnackbar.show(context: context, message: 'تم التحديث بنجاح!', type: SnackbarType.success);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, Color tp, Color border, Color surface) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.titleMedium(tp)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: surface,
            borderRadius: AppDimens.r8,
            border: Border.all(color: border, width: AppDimens.borderThick),
            boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
          ),
          child: TextField(
            obscureText: true,
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
