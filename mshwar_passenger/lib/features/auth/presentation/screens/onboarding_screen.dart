/// 🎯 Onboarding — Gumroad Style (Neo-brutalism) — تطابق تطبيق السائق
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../auth/presentation/screens/phone_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const List<_OnboardingPage> _pages = [
    _OnboardingPage(
      icon: Icons.directions_car_filled_rounded,
      iconColor: AppColors.primary,
      title: 'اطلب مشوارك\nبلمسة.',
      subtitle: 'نصلك بأقرب سائق في ثوانٍ.\nمشوارك الموثوق أينما كنت.',
    ),
    _OnboardingPage(
      icon: Icons.verified_user_rounded,
      iconColor: AppColors.info,
      title: 'رحلات آمنة\nومريحة.',
      subtitle: 'سائقون موثوقون، سيارات نظيفة، وتتبع مباشر لرحلتك من البداية للنهاية.',
    ),
    _OnboardingPage(
      icon: Icons.account_balance_wallet_rounded,
      iconColor: AppColors.warning,
      title: 'أسعار ثابتة\nوواضحة.',
      subtitle: 'اعرف تكلفة مشوارك قبل الطلب. لا مفاجآت، الدفع نقداً أو بالمحفظة.',
    ),
    _OnboardingPage(
      icon: Icons.location_on_rounded,
      iconColor: AppColors.success,
      title: 'تتبع رحلتك\nلحظة بلحظة.',
      subtitle: 'شارك موقعك مع عائلتك أثناء الرحلة لمزيد من الطمأنينة والأمان.',
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutExpo,
      );
    } else {
      _toPhone();
    }
  }

  void _toPhone() {
    Navigator.of(context).pushReplacement(
      MshwarPageRoute(builder: (_) => const PhoneScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg     = isDark ? AppColors.darkBg            : AppColors.lightBg;
    final tp     = isDark ? AppColors.darkTextPrimary    : AppColors.lightTextPrimary;
    final ts     = isDark ? AppColors.darkTextSecondary  : AppColors.lightTextSecondary;
    final border = isDark ? Colors.white                 : Colors.black;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── شريط العنوان + تخطي ─────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentPage < _pages.length - 1)
                    MshwarCardButton(
                      onTap: _toPhone,
                      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('تخطّ', style: AppTypography.titleMedium(ts)),
                    ),
                ],
              ),
            ),

            // ── الصفحات ──────────────────────────────
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) {
                  final page = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // الأيقونة البروتالية الضخمة
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: page.iconColor,
                            borderRadius: AppDimens.r8,
                            border: Border.all(color: Colors.black, width: 4),
                            boxShadow: const [
                              BoxShadow(color: Colors.black, offset: Offset(8, 8)),
                            ],
                          ),
                          child: Icon(page.icon, size: 64, color: Colors.black),
                        )
                        .animate(key: ValueKey('icon_$i'))
                        .scale(duration: 500.ms, curve: Curves.easeOutBack),

                        const SizedBox(height: 48),

                        // العنوان
                        Text(
                          page.title,
                          style: AppTypography.displayLarge(tp).copyWith(
                            height: 1.2,
                          ),
                        )
                        .animate(key: ValueKey('title_$i'))
                        .fade(duration: 400.ms, delay: 100.ms)
                        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutExpo),

                        const SizedBox(height: 20),

                        // النص في صندوق بروتالي (نفس ستايل الراكب الأصلي)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                            border: Border.all(color: border, width: 2),
                          ),
                          child: Text(
                            page.subtitle,
                            style: AppTypography.bodyLarge(tp).copyWith(height: 1.6),
                          ),
                        )
                        .animate(key: ValueKey('sub_$i'))
                        .fade(duration: 400.ms, delay: 200.ms),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ── الشريط السفلي (نقاط + زر) ───────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                  24, 16, 24, MediaQuery.of(context).padding.bottom + 16),
              child: Row(
                children: [
                  // نقاط التقدم البروتالية
                  Row(
                    children: List.generate(_pages.length, (i) {
                      final active = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.only(left: 8),
                        width: active ? 32 : 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.primary
                              : (isDark ? Colors.white24 : Colors.black12),
                          border:
                              active ? Border.all(color: Colors.black, width: 2) : null,
                        ),
                      );
                    }),
                  ),

                  const Spacer(),

                  // زر التالي / ابدأ
                  SizedBox(
                    width: 140,
                    child: MshwarButton(
                      label: _currentPage < _pages.length - 1 ? 'التالي' : 'ابدأ',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: _next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  const _OnboardingPage({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}
