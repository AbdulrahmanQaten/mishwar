/// 🗂️ الشاشة الحاوية (السائق) — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import 'driver_home_screen.dart';
import '../../../earnings/presentation/screens/earnings_screen.dart';
import '../../../profile/presentation/screens/driver_profile_screen.dart';

class DriverMainScreen extends StatefulWidget {
  const DriverMainScreen({super.key});

  @override
  State<DriverMainScreen> createState() => _DriverMainScreenState();
}

class _DriverMainScreenState extends State<DriverMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DriverHomeScreen(key: ValueKey(0)),
    EarningsScreen(key: ValueKey(1)),
    DriverProfileScreen(key: ValueKey(2)),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg  = isDark ? AppColors.darkBg : AppColors.lightBg;
    final tp  = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final ts  = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          // شاشة الخريطة دائماً بالأسفل للحفاظ على الأداء
          const DriverHomeScreen(),
          
          // الشاشات الأخرى تنزلق فوق الخريطة
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOutExpo,
            switchOutCurve: Curves.easeInExpo,
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(position: offsetAnimation, child: child);
            },
            child: _currentIndex == 0 
                ? const SizedBox.shrink(key: ValueKey(0)) 
                : Container(
                    key: ValueKey(_currentIndex),
                    color: bg,
                    child: _screens[_currentIndex],
                  ),
          ),
          
          // شريط تنقل عائم (Floating Brutalist Navbar)
          Positioned(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: AppDimens.r8,
                border: Border.all(color: border, width: AppDimens.borderThick),
                boxShadow: [
                  BoxShadow(color: border, offset: const Offset(4, 4), blurRadius: 0),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.map_rounded, Icons.map_outlined, 'الخريطة', tp, ts),
                  _buildNavItem(1, Icons.account_balance_wallet_rounded, Icons.account_balance_wallet_outlined, 'الأرباح', tp, ts),
                  _buildNavItem(2, Icons.person_rounded, Icons.person_outline_rounded, 'حسابي', tp, ts),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData onIcon, IconData offIcon, String label, Color tp, Color ts) {
    final active = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(active ? onIcon : offIcon, size: 28, color: active ? tp : ts),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.labelLarge(active ? tp : ts).copyWith(
              fontWeight: active ? FontWeight.w900 : FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
