/// ✉️ شاشة الرسائل — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

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
                  Expanded(child: Text('الرسائل', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return MshwarCardButton(
                    onTap: () {},
                    backgroundColor: index == 0 ? AppColors.primary : surface,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 48, height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.warning,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: const Icon(Icons.chat_bubble_rounded, color: Colors.black),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('الدعم الفني', style: AppTypography.titleLarge(index == 0 ? Colors.black : tp)),
                              Text('لقد تم حل مشكلتك الأخيرة...', style: AppTypography.bodySmall(index == 0 ? Colors.black87 : ts)),
                            ],
                          ),
                        ),
                        Text('الآن', style: AppTypography.labelLarge(index == 0 ? Colors.black : ts)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
