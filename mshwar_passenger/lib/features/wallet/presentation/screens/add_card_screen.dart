/// 💳 إضافة بطاقة بنكية — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../../shared/widgets/mshwar_snackbar.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

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
                  Expanded(child: Text('إضافة بطاقة بنكية', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.contactless_rounded, size: 32, color: Colors.black),
                            Text('VISA', style: AppTypography.displayLarge(Colors.black).copyWith(fontStyle: FontStyle.italic)),
                          ],
                        ),
                        Text('**** **** **** 1234', style: AppTypography.displayLarge(Colors.black)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('الاسم الكامل', style: AppTypography.titleMedium(Colors.black54)),
                            Text('12/28', style: AppTypography.titleMedium(Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  _buildInputField('رقم البطاقة', '0000 0000 0000 0000', tp, border, surface, icon: Icons.credit_card_rounded),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(child: _buildInputField('تاريخ الانتهاء', 'MM/YY', tp, border, surface)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildInputField('رمز الأمان (CVV)', '123', tp, border, surface)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildInputField('الاسم على البطاقة', 'الاسم الكامل', tp, border, surface),
                ],
              ),
            ),
            
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              child: MshwarButton(
                label: 'حفظ البطاقة',
                icon: Icons.save_rounded,
                onPressed: () {
                  MshwarSnackbar.show(context: context, message: 'تم إضافة البطاقة بنجاح!', type: SnackbarType.success);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, Color tp, Color border, Color surface, {IconData? icon}) {
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
            style: AppTypography.titleLarge(tp),
            keyboardType: label.contains('رقم') || label.contains('رمز') ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: icon != null ? Icon(icon, color: tp) : null,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
