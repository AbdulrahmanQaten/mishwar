/// 👤 شاشة الحساب (Profile) — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import 'settings_screen.dart';
import 'messages_screen.dart';
import 'gift_screen.dart';
import 'legal_screen.dart';
import 'help_screen.dart';
import '../../../wallet/presentation/screens/wallet_screen.dart';
import '../../../history/presentation/screens/history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MshwarCardButton(
  onTap: () => Navigator.pop(context),
  backgroundColor: surface,
  padding: const EdgeInsets.all(8),
  child: Icon(Icons.close_rounded, size: 28, color: tp),
),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Profile Header
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: border, width: AppDimens.borderThick),
                      boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('أحمد محمد', style: AppTypography.displayLarge(tp)),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.warning,
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star_rounded, size: 16, color: Colors.black),
                                  const SizedBox(width: 4),
                                  Text('5.0', style: AppTypography.labelLarge(Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 72, height: 72,
                          decoration: BoxDecoration(
                            color: AppColors.info,
                            border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                          ),
                          child: const Icon(Icons.person_rounded, size: 40, color: Colors.black),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Quick Actions
                  Row(
                    children: [
                      Expanded(child: _buildQuickAction(Icons.help_rounded, 'المساعدة', AppColors.primary, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const HelpScreen())))),
                      const SizedBox(width: 16),
                      Expanded(child: _buildQuickAction(Icons.payment_rounded, 'الدفع', AppColors.info, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const WalletScreen())))),
                      const SizedBox(width: 16),
                      Expanded(child: _buildQuickAction(Icons.history_rounded, 'النشاط', AppColors.warning, onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const HistoryScreen())))),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Settings List
                  _buildListTile(context, Icons.settings_rounded, 'الإعدادات', surface, border, tp, const SettingsScreen()),
                  const SizedBox(height: 12),
                  _buildListTile(context, Icons.mail_rounded, 'الرسائل', surface, border, tp, const MessagesScreen()),
                  const SizedBox(height: 12),
                  _buildListTile(context, Icons.card_giftcard_rounded, 'أرسل هدية', surface, border, tp, const GiftScreen()),
                  const SizedBox(height: 12),
                  _buildListTile(context, Icons.info_rounded, 'المعلومات القانونية', surface, border, tp, const LegalScreen()),
                  
                  const SizedBox(height: 32),
                  
                  // Logout
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: AppDimens.r8,
                      border: Border.all(color: Colors.black, width: AppDimens.borderThick),
                      boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
                    ),
                    child: Center(
                      child: Text('تسجيل الخروج', style: AppTypography.titleLarge(Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, Color bg, {VoidCallback? onTap}) {
    return MshwarCardButton(
      onTap: onTap ?? () {},
      backgroundColor: bg,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Icon(icon, size: 32, color: Colors.black),
          const SizedBox(height: 8),
          Text(label, style: AppTypography.titleMedium(Colors.black)),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title, Color surface, Color border, Color tp, Widget destination) {
    return MshwarCardButton(
      onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => destination)),
      backgroundColor: surface,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: tp, size: 28),
          const SizedBox(width: 16),
          Expanded(child: Text(title, style: AppTypography.titleLarge(tp))),
        ],
      ),
    );
  }
}
