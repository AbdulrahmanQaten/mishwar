/// 🎬 صفحات الترحيب (Onboarding) — السائق — Gumroad Style
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'phone_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardingData> _pages = [
    _OnboardingData(
      icon: Icons.local_taxi_rounded,
      iconColor: AppColors.primary,
      title: 'مرحباً كابتن!',
      subtitle: 'انضم إلى آلاف الكباتن في اليمن واستقبل رحلات يومية من خلال تطبيق مشوار.',
    ),
    _OnboardingData(
      icon: Icons.wifi_tethering_rounded,
      iconColor: AppColors.info,
      title: 'شغّل عملك بنفسك',
      subtitle: 'اختر وقت عملك بحرية تامة. اضغط "اذهب للعمل" واستقبل الطلبات القريبة منك فوراً.',
    ),
    _OnboardingData(
      icon: Icons.payments_rounded,
      iconColor: AppColors.success,
      title: 'أرباح مضمونة',
      subtitle: 'تتبع أرباحك اليومية والأسبوعية بشفافية تامة. أنت تعرف كل ريال تكسبه.',
    ),
    _OnboardingData(
      icon: Icons.navigation_rounded,
      iconColor: AppColors.warning,
      title: 'ملاحة مجانية',
      subtitle: 'نستخدم خرائط جوجل مجاناً لتوصيلك لأي مكان في اليمن بدقة وسهولة.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutExpo,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MshwarPageRoute(builder: (_) => const PhoneScreen()),
      );
    }
  }

  void _skip() {
    Navigator.pushReplacement(
      context,
      MshwarPageRoute(builder: (_) => const PhoneScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg  = isDark ? AppColors.darkBg   : AppColors.lightBg;
    final tp  = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final ts  = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // زر تخطي
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentPage < _pages.length - 1)
                    MshwarCardButton(
                      onTap: _skip,
                      backgroundColor: bg,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('تخطي', style: AppTypography.titleMedium(ts)),
                    ),
                ],
              ),
            ),

            // الصفحات
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // أيقونة بروتالية ضخمة
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: page.iconColor,
                            borderRadius: AppDimens.r8,
                            border: Border.all(color: Colors.black, width: 4),
                            boxShadow: const [
                              BoxShadow(color: Colors.black, offset: Offset(8, 8)),
                            ],
                          ),
                          child: Icon(page.icon, size: 72, color: Colors.black),
                        )
                        .animate(key: ValueKey('icon_$index'))
                        .scale(duration: 500.ms, curve: Curves.easeOutBack)
                        .then()
                        .shimmer(duration: 600.ms),

                        const SizedBox(height: 56),

                        Text(
                          page.title,
                          style: AppTypography.displayLarge(tp).copyWith(
                            fontSize: 40,
                            letterSpacing: -1,
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate(key: ValueKey('title_$index'))
                        .fade(duration: 400.ms, delay: 100.ms)
                        .slideY(begin: 0.3, end: 0, curve: Curves.easeOutExpo),

                        const SizedBox(height: 20),

                        Text(
                          page.subtitle,
                          style: AppTypography.bodyLarge(ts),
                          textAlign: TextAlign.center,
                        )
                        .animate(key: ValueKey('sub_$index'))
                        .fade(duration: 400.ms, delay: 200.ms),
                      ],
                    ),
                  );
                },
              ),
            ),

            // نقاط التقدم
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                final active = _currentPage == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: active ? 32 : 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary : border.withOpacity(0.2),
                    border: active ? Border.all(color: border, width: 2) : null,
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            // زر التالي
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, MediaQuery.of(context).padding.bottom + 16),
              child: MshwarButton(
                label: _currentPage == _pages.length - 1 ? 'ابدأ التسجيل' : 'التالي',
                icon: _currentPage == _pages.length - 1
                    ? Icons.arrow_forward_rounded
                    : Icons.navigate_next_rounded,
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  const _OnboardingData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}
