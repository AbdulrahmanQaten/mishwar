/// 👤 شاشة الاسم — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../home/presentation/screens/main_screen.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _firstCtrl = TextEditingController();
  final _lastCtrl = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool _loading = false;

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MshwarPageRoute(builder: (_) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg  = isDark ? AppColors.darkBg   : AppColors.lightBg;
    final tp  = isDark ? AppColors.darkTextPrimary   : AppColors.lightTextPrimary;
    final border = isDark ? Colors.white : Colors.black;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Form(
          key: _form,
          child: Column(
            children: [
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

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Text('ما هو اسمك؟', style: AppTypography.displayLarge(tp)),
                      const SizedBox(height: 48),

                      // First Name Box
                      Container(
                        decoration: BoxDecoration(
                          color: surface,
                          border: Border.all(color: border, width: AppDimens.borderThick),
                          boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                        ),
                        child: TextFormField(
                          controller: _firstCtrl,
                          textInputAction: TextInputAction.next,
                          style: AppTypography.titleLarge(tp),
                          validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                          decoration: const InputDecoration(
                            hintText: 'الاسم الأول',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Last Name Box
                      Container(
                        decoration: BoxDecoration(
                          color: surface,
                          border: Border.all(color: border, width: AppDimens.borderThick),
                          boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                        ),
                        child: TextFormField(
                          controller: _lastCtrl,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          style: AppTypography.titleLarge(tp),
                          validator: (v) => v!.isEmpty ? 'مطلوب' : null,
                          decoration: const InputDecoration(
                            hintText: 'اسم العائلة',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
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
                  label: 'التالي',
                  isLoading: _loading,
                  onPressed: _submit,
                  icon: Icons.arrow_forward_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
