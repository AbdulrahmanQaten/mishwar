/// ⏳ شاشة قيد المراجعة (السائق) — Gumroad Style
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../home/presentation/screens/driver_main_screen.dart';

class PendingApprovalScreen extends StatefulWidget {
  const PendingApprovalScreen({super.key});

  @override
  State<PendingApprovalScreen> createState() => _PendingApprovalScreenState();
}

class _PendingApprovalScreenState extends State<PendingApprovalScreen> {
  bool _isApproved = false;

  @override
  void initState() {
    super.initState();
    // محاكاة قبول الإدارة بعد 4 ثوانٍ
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() => _isApproved = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg  = isDark ? AppColors.darkBg   : AppColors.lightBg;
    final tp  = isDark ? AppColors.darkTextPrimary   : AppColors.lightTextPrimary;
    final ts  = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: _isApproved ? AppColors.success : AppColors.warning,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 4),
                  boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(8, 8))],
                ),
                child: Icon(
                  _isApproved ? Icons.verified_rounded : Icons.hourglass_top_rounded,
                  size: 80,
                  color: Colors.black,
                ),
              )
              .animate(target: _isApproved ? 1 : 0)
              .rotate(duration: 400.ms, curve: Curves.easeOutBack),
              
              const SizedBox(height: 40),
              
              Text(
                _isApproved ? 'تمت الموافقة!' : 'قيد المراجعة',
                style: AppTypography.displayLarge(tp).copyWith(fontSize: 40, letterSpacing: -1),
              ),
              const SizedBox(height: 16),
              
              Text(
                _isApproved 
                    ? 'أهلاً بك كابتن في عائلة مشوار. يمكنك الآن بدء العمل واستقبال الطلبات.' 
                    : 'طلبك الآن قيد المراجعة من قبل الإدارة. سنتحقق من بياناتك وصورك ونرد عليك في أقرب وقت.',
                style: AppTypography.titleLarge(ts),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 64),
              
              if (_isApproved)
                MshwarButton(
                  label: 'ابدأ العمل الآن',
                  icon: Icons.local_taxi_rounded,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MshwarPageRoute(builder: (_) => const DriverMainScreen()),
                    );
                  },
                ).animate().fade().slideY(begin: 0.5, end: 0, curve: Curves.easeOutBack)
              else
                Column(
                  children: [
                    const CircularProgressIndicator(color: AppColors.primary),
                    const SizedBox(height: 24),
                    Text('يرجى الانتظار...', style: AppTypography.titleMedium(ts)),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
