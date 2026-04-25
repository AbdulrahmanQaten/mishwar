/// 🔢 شاشة رمز التحقق (OTP) للسائق — Gumroad Style
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../../shared/widgets/mshwar_snackbar.dart';
import 'registration_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _ctrl = TextEditingController();
  bool _isLoading = false;
  bool _isError = false;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _verify(String code) async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });

    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    if (code == '1234') {
      Navigator.pushReplacement(
        context,
        MshwarPageRoute(builder: (_) => const RegistrationScreen()),
      );
    } else {
      setState(() {
        _isLoading = false;
        _isError = true;
        _ctrl.clear();
      });
      MshwarSnackbar.show(
        context: context,
        message: 'الرمز غير صحيح، جرب 1234',
        type: SnackbarType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final bg      = isDark ? AppColors.darkBg           : AppColors.lightBg;
    final tp      = isDark ? AppColors.darkTextPrimary   : AppColors.lightTextPrimary;
    final ts      = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final surface = isDark ? AppColors.surfaceDark       : AppColors.surfaceLight;
    final border  = isDark ? Colors.white                : Colors.black;

    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: AppTypography.displayLarge(tp).copyWith(fontSize: 28),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: AppDimens.r8,
        border: Border.all(color: border, width: AppDimens.borderThick),
        boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
      ),
    );

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── زر الرجوع ─────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerRight,
                child: MshwarCardButton(
                  onTap: () => Navigator.pop(context),
                  backgroundColor: surface,
                  padding: const EdgeInsets.all(8),
                  child: Icon(Icons.arrow_back_rounded, size: 24, color: tp),
                ),
              ),
            ),

            // ── المحتوى ───────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'أدخل الرمز',
                      style: AppTypography.displayLarge(tp)
                          .copyWith(fontSize: 40, letterSpacing: -1),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'أرسلنا رمزاً من 4 أرقام إلى\n+967 ${widget.phone}',
                      style: AppTypography.bodyLarge(ts),
                    ),
                    const SizedBox(height: 48),

                    // ── حقول OTP ──────────────────────
                    Center(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Pinput(
                          controller: _ctrl,
                          length: 4,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                          forceErrorState: _isError,
                          onCompleted: _verify,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── إعادة إرسال ───────────────────
                    Center(
                      child: MshwarCardButton(
                        onTap: () {},
                        backgroundColor: bg,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        child: Text('إعادة إرسال الرمز',
                            style: AppTypography.titleLarge(tp)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── زر التحقق ─────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
              child: MshwarButton(
                label: 'تحقق',
                isLoading: _isLoading,
                icon: Icons.arrow_forward_rounded,
                onPressed: () {
                  if (_ctrl.text.length == 4) _verify(_ctrl.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
