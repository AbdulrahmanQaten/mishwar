/// 📱 شاشة رقم الهاتف (السائق) — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import 'otp_screen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: const Icon(Icons.phone_iphone_rounded, size: 32, color: Colors.black),
              ),
              const SizedBox(height: 24),
              Text(
                'ما هو رقمك؟',
                style: AppTypography.displayLarge(tp).copyWith(fontSize: 40, letterSpacing: -1),
              ),
              const SizedBox(height: 12),
              Text(
                'سنرسل لك رمز تأكيد عبر رسالة نصية للدخول إلى حساب الكابتن.',
                style: AppTypography.bodyLarge(ts),
              ),
              const SizedBox(height: 48),
              
              // حقل إدخال بروتالي صلب
              Container(
                decoration: BoxDecoration(
                  color: surface,
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
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: border, width: AppDimens.borderThick)),
                      ),
                      child: Text('+967', style: AppTypography.titleLarge(tp)),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: AppTypography.titleLarge(tp).copyWith(letterSpacing: 2),
                        decoration: InputDecoration(
                          hintText: '7xx xxx xxx',
                          hintStyle: AppTypography.titleLarge(ts),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              MshwarButton(
                label: 'متابعة',
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  if (_phoneController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MshwarPageRoute(builder: (_) => OtpScreen(phone: _phoneController.text)),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
