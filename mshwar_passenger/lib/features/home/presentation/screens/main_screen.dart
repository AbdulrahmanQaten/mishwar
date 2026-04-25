/// 🗂️ الشاشة الحاوية (Main Screen) — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../history/presentation/screens/history_screen.dart';
import '../../../wallet/presentation/screens/wallet_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    HistoryScreen(),
    WalletScreen(),
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
          // 1. الشاشة الرئيسية والخريطة دائمًا في الخلفية للحفاظ على حالتها
          const HomeScreen(),
          
          // 2. شاشات النشاط والمحفظة تنزلق فوق الخريطة
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOutExpo,
            switchOutCurve: Curves.easeInExpo,
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(1.0, 0.0), // انزلاق من اليمين كأنها ورقة صلبة
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(position: offsetAnimation, child: child);
            },
            child: _currentIndex == 1 
                ? const HistoryScreen(key: ValueKey(1))
                : _currentIndex == 2 
                    ? const WalletScreen(key: ValueKey(2))
                    : const SizedBox.shrink(key: ValueKey(0)), // فارغ لنرى الخريطة
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
                  BoxShadow(
                    color: border,
                    offset: const Offset(4, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.home_filled, Icons.home_outlined, 'الرئيسية', tp, ts),
                  _buildNavItem(1, Icons.receipt_long_rounded, Icons.receipt_long_outlined, 'النشاط', tp, ts),
                  _buildNavItem(2, Icons.account_balance_wallet_rounded, Icons.account_balance_wallet_outlined, 'المحفظة', tp, ts),
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
