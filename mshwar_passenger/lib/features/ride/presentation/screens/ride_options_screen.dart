/// 🚗 شاشة خيارات الرحلة (Ride Options) — Gumroad Style

import 'package:flutter/material.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import 'searching_screen.dart';

class RideOptionsScreen extends StatefulWidget {
  const RideOptionsScreen({super.key});

  @override
  State<RideOptionsScreen> createState() => _RideOptionsScreenState();
}

class _RideOptionsScreenState extends State<RideOptionsScreen> {
  int _selectedOption = 0;
  bool _loading = false;

  final List<Map<String, dynamic>> _options = [
    {
      'name': 'مشوار توفير',
      'time': '٤ دقائق',
      'price': '١٢٠٠ ر.ي',
      'icon': Icons.directions_car_filled_rounded,
      'color': AppColors.primary,
    },
    {
      'name': 'مشوار بلس',
      'time': '٦ دقائق',
      'price': '١٨٠٠ ر.ي',
      'icon': Icons.airport_shuttle_rounded,
      'color': AppColors.info,
    },
    {
      'name': 'مشوار مميز',
      'time': '٧ دقائق',
      'price': '٢٥٠٠ ر.ي',
      'icon': Icons.local_taxi_rounded,
      'color': AppColors.warning,
    },
  ];

  void _confirm() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MshwarPageRoute(builder: (_) => const SearchingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final tp = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final border = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: Stack(
        children: [
          // ── الخريطة بالخلفية ────────────────────────
          Container(color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE5E5E5)),

          // ── لوحة الخيارات في الأسفل ─────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: AppDimens.bottomSheetRadius,
                border: Border(
                  top: BorderSide(color: border, width: AppDimens.borderThick),
                ),
                boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(0, -4), blurRadius: 0)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 48, height: 6,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white24 : Colors.black12,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text('اختر نوع الرحلة', style: AppTypography.displayLarge(tp)),
                  const SizedBox(height: 16),

                  ...List.generate(_options.length, (i) {
                    final isSelected = _selectedOption == i;
                    final opt = _options[i];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedOption = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? opt['color'] : surface,
                          borderRadius: AppDimens.r8,
                          border: Border.all(color: border, width: AppDimens.borderThick),
                          boxShadow: [
                            if (isSelected) BoxShadow(color: border, offset: const Offset(4, 4), blurRadius: 0)
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isDark ? AppColors.darkBg : AppColors.lightBg,
                                border: Border.all(color: border, width: 2),
                              ),
                              child: Icon(opt['icon'], color: tp),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(opt['name'], style: AppTypography.titleLarge(isSelected ? Colors.black : tp)),
                                  Text(opt['time'], style: AppTypography.bodySmall(isSelected ? Colors.black87 : AppColors.lightTextHint)),
                                ],
                              ),
                            ),
                            Text(opt['price'], style: AppTypography.titleLarge(isSelected ? Colors.black : tp)),
                          ],
                        ),
                      ),
                    );
                  }).animate(interval: 100.ms).fade(duration: 300.ms).slideX(begin: 0.1, end: 0, curve: Curves.easeOutBack),

                  const SizedBox(height: 16),

                  // طرق الدفع
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: border, width: AppDimens.borderThick),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.money_rounded, color: AppColors.success, size: 28),
                        const SizedBox(width: 12),
                        Text('نقداً', style: AppTypography.titleMedium(tp)),
                        const Spacer(),
                        Icon(Icons.keyboard_arrow_right_rounded, color: tp),
                      ],
                    ),
                  ).animate().fade(delay: 400.ms),

                  const SizedBox(height: 24),

                  MshwarButton(
                    label: 'تأكيد الطلب',
                    isLoading: _loading,
                    onPressed: _confirm,
                  ).animate().fade(delay: 500.ms).slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),
                  
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ).animate().slideY(begin: 1.0, end: 0, duration: 400.ms, curve: Curves.easeOutExpo),
          ),
          
          // زر العودة (عائم بستايل بروتالي)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            child: MshwarCardButton(
  onTap: () => Navigator.pop(context),
  backgroundColor: surface,
  padding: const EdgeInsets.all(8),
  child: Icon(Icons.arrow_back_rounded, size: 24, color: tp),
),
          ),
        ],
      ),
    );
  }
}
