/// 💳 إضافة رصيد — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../../shared/widgets/mshwar_snackbar.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'add_card_screen.dart';

class AddFundsScreen extends StatefulWidget {
  const AddFundsScreen({super.key});

  @override
  State<AddFundsScreen> createState() => _AddFundsScreenState();
}

class _AddFundsScreenState extends State<AddFundsScreen> {
  int _selectedAmount = 1000;

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
                  Expanded(child: Text('إضافة رصيد', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),
            
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text('الرصيد الحالي: ٠ ر.ي', style: AppTypography.titleLarge(ts)),
                  const SizedBox(height: 16),
                  Text('اختر المبلغ المراد إضافته', style: AppTypography.displayLarge(tp)),
                  const SizedBox(height: 24),
                  
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildAmountBtn(500, border, surface, tp),
                      _buildAmountBtn(1000, border, surface, tp),
                      _buildAmountBtn(2000, border, surface, tp),
                      _buildAmountBtn(5000, border, surface, tp),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  Text('طريقة الدفع', style: AppTypography.titleLarge(tp)),
                  const SizedBox(height: 16),
                  
                  _buildPaymentMethod(Icons.credit_card_rounded, 'بطاقة ائتمانية', 'إضافة بطاقة جديدة', AppColors.primary, border, surface, tp, ts, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const AddCardScreen()))),
                  _buildPaymentMethod(Icons.account_balance_wallet_rounded, 'الكريمي جوال', 'ربط حساب الكريمي', AppColors.warning, border, surface, tp, ts),
                ],
              ),
            ),
            
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              child: MshwarButton(
                label: 'تأكيد إضافة $_selectedAmount ر.ي',
                icon: Icons.add_rounded,
                onPressed: () {
                  MshwarSnackbar.show(context: context, message: 'تمت العملية بنجاح!', type: SnackbarType.success);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountBtn(int amount, Color border, Color surface, Color tp) {
    final isSelected = _selectedAmount == amount;
    return GestureDetector(
      onTap: () => setState(() => _selectedAmount = amount),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : surface,
          borderRadius: AppDimens.r8,
          border: Border.all(color: border, width: AppDimens.borderThick),
          boxShadow: [BoxShadow(color: border, offset: Offset(isSelected ? 0 : 4, isSelected ? 0 : 4))],
        ),
        child: Center(
          child: Text(
            '$amount',
            style: AppTypography.displayLarge(isSelected ? Colors.black : tp),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(IconData icon, String title, String subtitle, Color iconBg, Color border, Color surface, Color tp, Color ts, {VoidCallback? onTap}) {
    return MshwarCardButton(
      onTap: onTap ?? () {},
      backgroundColor: surface,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
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
