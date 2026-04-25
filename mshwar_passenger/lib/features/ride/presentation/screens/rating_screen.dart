/// ⭐ شاشة التقييم (Rating) — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../home/presentation/screens/main_screen.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _rating = 0;
  bool _loading = false;
  final _feedbackCtrl = TextEditingController();

  @override
  void dispose() {
    _feedbackCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MshwarPageRoute(builder: (_) => const MainScreen()),
      (r) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBg : AppColors.lightBg;
    final tp = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final border = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    
                    Text('كيف كانت رحلتك؟', style: AppTypography.displayLarge(tp))
                        .animate().fade(duration: 400.ms).slideY(begin: -0.2, end: 0, curve: Curves.easeOutBack),
                    
                    const SizedBox(height: 32),

                    // الكابتن
                    Container(
                      width: 100, height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.info,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
                      ),
                      child: const Icon(Icons.person_rounded, size: 56, color: Colors.black),
                    ).animate().scaleXY(begin: 0.8, end: 1.0, duration: 400.ms, curve: Curves.easeOutBack),

                    const SizedBox(height: 16),
                    Text('مع محمد أحمد', style: AppTypography.titleLarge(tp)),
                    
                    const SizedBox(height: 48),

                    // النجوم
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (i) {
                        final filled = i < _rating;
                        return GestureDetector(
                          onTap: () => setState(() => _rating = i + 1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: filled ? AppColors.warning : Colors.transparent,
                              borderRadius: AppDimens.r8,
                              border: Border.all(color: filled ? Colors.black : tp, width: 2),
                            ),
                            child: Icon(
                              Icons.star_rounded,
                              size: 40,
                              color: filled ? Colors.black : tp,
                            ),
                          ),
                        ).animate().fade(delay: (100 * i).ms).slideY(begin: 0.5, end: 0, curve: Curves.easeOutBack);
                      }),
                    ),

                    const SizedBox(height: 48),

                    // إكرامية (Tip)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text('إكرامية للكابتن؟', style: AppTypography.titleLarge(tp)),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: _buildTipBtn('٢٠٠', isDark, tp, surface, border)),
                        Expanded(child: _buildTipBtn('٥٠٠', isDark, tp, surface, border)),
                        Expanded(child: _buildTipBtn('١٠٠٠', isDark, tp, surface, border)),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // صندوق الملاحظات
                    Container(
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: AppDimens.r8,
                        border: Border.all(color: border, width: AppDimens.borderThick),
                        boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                      ),
                      child: TextField(
                        controller: _feedbackCtrl,
                        maxLines: 3,
                        style: AppTypography.titleMedium(tp),
                        decoration: const InputDecoration(
                          hintText: 'هل لديك ملاحظات إضافية؟',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
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
                label: 'إرسال التقييم',
                isLoading: _loading,
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipBtn(String amount, bool isDark, Color tp, Color surface, Color border) {
    return MshwarCardButton(
      onTap: () {},
      backgroundColor: surface,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text('$amount ر.ي', style: AppTypography.titleMedium(tp)),
      ),
    );
  }
}
