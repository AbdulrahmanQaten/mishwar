/// 💳 شاشة المحفظة (Wallet) — Gumroad Style (Neo-brutalism) + Animation

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'add_funds_screen.dart';
import '../../../profile/presentation/screens/gift_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text('المحفظة', style: AppTypography.displayLarge(tp))
                  .animate()
                  .fade(duration: 400.ms)
                  .slideY(begin: -0.2, end: 0, curve: Curves.easeOutBack),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 120), // حماية من شريط التنقل
                children: [
                  // بطاقة الرصيد
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(6, 6))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('رصيد مشوار', style: AppTypography.titleLarge(Colors.black)),
                        const SizedBox(height: 8),
                        Text('٠.٠٠ ر.ي', style: AppTypography.displayLarge(Colors.black)),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(child: _buildActionBtn('إضافة رصيد', Icons.add_rounded, AppColors.info, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const AddFundsScreen())))),
                            const SizedBox(width: 12),
                            Expanded(child: _buildActionBtn('إرسال هدية', Icons.card_giftcard_rounded, AppColors.warning, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const GiftScreen())))),
                          ],
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fade(delay: 100.ms, duration: 400.ms)
                  .scaleXY(begin: 0.9, end: 1.0, curve: Curves.easeOutBack),

                  const SizedBox(height: 48),
                  Text('طرق الدفع', style: AppTypography.displayLarge(tp))
                      .animate()
                      .fade(delay: 200.ms)
                      .slideX(begin: 0.1, end: 0, curve: Curves.easeOutBack),
                  const SizedBox(height: 16),

                  _buildListTile(Icons.money_rounded, 'نقداً', isDark, tp, border, surface)
                      .animate()
                      .fade(delay: 300.ms, duration: 400.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),
                  
                  const SizedBox(height: 16),
                  
                  _buildListTile(Icons.credit_card_rounded, 'إضافة طريقة دفع', isDark, tp, border, surface, isAction: true)
                      .animate()
                      .fade(delay: 400.ms, duration: 400.ms)
                      .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn(String label, IconData icon, Color color, {VoidCallback? onTap}) {
    return MshwarCardButton(
      onTap: onTap ?? () {},
      backgroundColor: color,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Colors.black),
          const SizedBox(width: 8),
          Text(label, style: AppTypography.labelLarge(Colors.black)),
        ],
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, bool isDark, Color tp, Color border, Color surface, {bool isAction = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: AppDimens.r8,
        border: Border.all(color: border, width: AppDimens.borderThick),
        boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
      ),
      child: Row(
        children: [
          Icon(icon, color: tp, size: 32),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: AppTypography.titleLarge(tp))),
          Icon(Icons.arrow_forward_rounded, color: tp),
        ],
      ),
    );
  }
}
