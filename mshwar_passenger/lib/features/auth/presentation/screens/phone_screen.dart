/// 📱 شاشة الهاتف — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import 'package:flutter/services.dart';
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
  final _ctrl  = TextEditingController();
  final _form  = GlobalKey<FormState>();
  bool  _loading = false;
  String _code  = '+967';

  final List<Map<String, dynamic>> _countries = [
    {'code': '+967', 'flag': '🇾🇪', 'name': 'اليمن',    'digits': 9},
    {'code': '+966', 'flag': '🇸🇦', 'name': 'السعودية', 'digits': 9},
    {'code': '+971', 'flag': '🇦🇪', 'name': 'الإمارات', 'digits': 9},
    {'code': '+965', 'flag': '🇰🇼', 'name': 'الكويت',   'digits': 8},
  ];

  Map<String, dynamic> get _selected => _countries.firstWhere((c) => c['code'] == _code);
  int get _digits => _selected['digits'] as int;

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() => _loading = false);
    if (!mounted) return;
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => OtpScreen(phone: '$_code ${_ctrl.text.trim()}'),
      ),
    );
  }

  void _pickCountry() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg     = isDark ? AppColors.darkBg    : AppColors.lightBg;
    final border = isDark ? Colors.white : Colors.black;

    showModalBottomSheet(
      context: context,
      backgroundColor: bg,
      shape: RoundedRectangleBorder(
        borderRadius: AppDimens.bottomSheetRadius,
        side: BorderSide(color: border, width: AppDimens.borderThick),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _countries.map((c) {
            final active = c['code'] == _code;
            return InkWell(
              onTap: () {
                setState(() => _code = c['code'] as String);
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: active ? AppColors.primary.withOpacity(0.2) : Colors.transparent,
                child: Row(
                  children: [
                    Text(c['flag'] as String, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 16),
                    Expanded(child: Text(c['name'] as String, style: AppTypography.titleMedium(isDark ? Colors.white : Colors.black))),
                    Text(c['code'] as String, style: AppTypography.titleMedium(isDark ? Colors.white : Colors.black)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
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
                      Text('أدخل رقم هاتفك', style: AppTypography.displayLarge(tp)),
                      const SizedBox(height: 32),

                      Container(
                        decoration: BoxDecoration(
                          color: surface,
                          borderRadius: AppDimens.r8,
                          border: Border.all(color: border, width: AppDimens.borderThick),
                          boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: _pickCountry,
                              child: Container(
                                height: 56,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  border: Border(left: BorderSide(color: border, width: AppDimens.borderThick)),
                                ),
                                child: Row(
                                  children: [
                                    Text(_selected['flag'] as String, style: const TextStyle(fontSize: 22)),
                                    const SizedBox(width: 8),
                                    Text(_code, style: AppTypography.titleMedium(tp)),
                                    const SizedBox(width: 4),
                                    Icon(Icons.arrow_drop_down, color: tp),
                                  ],
                                ),
                              ),
                            ),
                            
                            Expanded(
                              child: TextFormField(
                                controller: _ctrl,
                                keyboardType: TextInputType.phone,
                                textDirection: TextDirection.ltr,
                                maxLength: _digits,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                style: AppTypography.titleLarge(tp).copyWith(letterSpacing: 2),
                                validator: (v) {
                                  if (v == null || v.isEmpty) return 'مطلوب';
                                  if (v.length < _digits) return 'أرقام ناقصة';
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  counterText: '',
                                  hintText: 'XXXXXXXXX',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
                child: MshwarButton(
                  label: 'متابعة',
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
