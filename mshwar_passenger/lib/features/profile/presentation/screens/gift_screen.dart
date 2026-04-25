/// 🎁 شاشة الهدية — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../../shared/widgets/mshwar_snackbar.dart';

class GiftScreen extends StatelessWidget {
  const GiftScreen({super.key});

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
                  Expanded(child: Text('أرسل هدية', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 120, height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.warning,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
                      ),
                      child: const Icon(Icons.card_giftcard_rounded, size: 64, color: Colors.black),
                    ),
                    const SizedBox(height: 32),
                    
                    Text('أهدِ من تحب مشواراً!', style: AppTypography.displayLarge(tp), textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    Text('قم بإدخال رقم هاتف صديقك وسنقوم بإرسال رصيد لمحفظته فوراً.', style: AppTypography.bodyLarge(tp), textAlign: TextAlign.center),
                    
                    const SizedBox(height: 48),
                    
                    Container(
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: AppDimens.r8,
                        border: Border.all(color: border, width: AppDimens.borderThick),
                        boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                      ),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        style: AppTypography.titleLarge(tp),
                        decoration: const InputDecoration(
                          hintText: 'رقم هاتف الصديق',
                          prefixIcon: Icon(Icons.phone_rounded),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    Container(
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: AppDimens.r8,
                        border: Border.all(color: border, width: AppDimens.borderThick),
                        boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: AppTypography.titleLarge(tp),
                        decoration: const InputDecoration(
                          hintText: 'المبلغ (ر.ي)',
                          prefixIcon: Icon(Icons.attach_money_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              child: MshwarButton(
                label: 'إرسال الهدية',
                icon: Icons.send_rounded,
                onPressed: () {
                  MshwarSnackbar.show(
                    context: context, 
                    message: 'تم الإرسال بنجاح!', 
                    type: SnackbarType.success
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
