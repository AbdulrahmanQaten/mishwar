/// 📍 شاشة اختيار الوجهة — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({super.key});

  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

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
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(width: 12, height: 12, decoration: BoxDecoration(color: AppColors.primary, border: Border.all(color: border, width: 2))),
                      Container(width: 4, height: 40, color: border),
                      Container(width: 12, height: 12, color: border),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: surface,
                            border: Border.all(color: border, width: AppDimens.borderThick),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('الموقع الحالي', style: AppTypography.titleMedium(ts)),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: surface,
                            border: Border.all(color: border, width: AppDimens.borderThick),
                            boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                          ),
                          child: TextField(
                            controller: _searchCtrl,
                            style: AppTypography.titleMedium(tp),
                            decoration: const InputDecoration(
                              hintText: 'إلى أين؟',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.info,
                      border: Border.all(color: border, width: AppDimens.borderThick),
                      boxShadow: [BoxShadow(color: border, offset: const Offset(2, 2))],
                    ),
                    child: Icon(Icons.add_rounded, size: 24, color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildListItem(Icons.home_filled, 'المنزل', 'الشيخ عثمان، عدن', isDark, tp, ts, border, surface),
                  const SizedBox(height: 16),
                  _buildListItem(Icons.work_rounded, 'العمل', 'خورمكسر، الشارع الرئيسي', isDark, tp, ts, border, surface),
                  const SizedBox(height: 16),
                  _buildListItem(Icons.history_rounded, 'كريتر، عدن مول', 'اليمن، عدن', isDark, tp, ts, border, surface),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(IconData icon, String title, String subtitle, bool isDark, Color tp, Color ts, Color border, Color surface) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: surface,
        border: Border.all(color: border, width: AppDimens.borderThick),
        boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary,
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
        ],
      ),
    );
  }
}
