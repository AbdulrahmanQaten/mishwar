/// 📝 شاشة التسجيل المتكاملة (السائق) — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_button.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../shared/widgets/mshwar_snackbar.dart';
import 'pending_approval_screen.dart';

// ======================================================
// نموذج بيانات رفع الصورة
// ======================================================
class _PhotoSlot {
  final String key;
  final String label;
  final String hint;
  final IconData icon;
  bool uploaded;

  _PhotoSlot({
    required this.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.uploaded = false,
  });
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _agreed = false;

  // ======================================================
  // قائمة صور المركبة المطلوبة (5 صور)
  // ======================================================
  final List<_PhotoSlot> _vehiclePhotos = [
    _PhotoSlot(key: 'front', label: 'واجهة السيارة (أمام)', hint: 'تأكد أن اللوحة واضحة', icon: Icons.directions_car_rounded),
    _PhotoSlot(key: 'back', label: 'مؤخرة السيارة (خلف)', hint: 'تأكد أن اللوحة واضحة', icon: Icons.directions_car_filled_rounded),
    _PhotoSlot(key: 'left', label: 'الجانب الأيسر', hint: 'السيارة كاملة في الصورة', icon: Icons.chevron_left_rounded),
    _PhotoSlot(key: 'right', label: 'الجانب الأيمن', hint: 'السيارة كاملة في الصورة', icon: Icons.chevron_right_rounded),
    _PhotoSlot(key: 'interior', label: 'المقصورة الداخلية', hint: 'من مقعد السائق إلى الخلف', icon: Icons.airline_seat_recline_extra_rounded),
  ];

  // ======================================================
  // قائمة صور الهوية المطلوبة (3 صور)
  // ======================================================
  final List<_PhotoSlot> _idPhotos = [
    _PhotoSlot(key: 'id_front', label: 'البطاقة الشخصية (وجه أمام)', hint: 'الصورة والاسم واضحَيْن', icon: Icons.credit_card_rounded),
    _PhotoSlot(key: 'id_back', label: 'البطاقة الشخصية (ظهر)', hint: 'جميع البيانات واضحة', icon: Icons.credit_card_off_rounded),
    _PhotoSlot(key: 'selfie_id', label: 'سيلفي مع البطاقة', hint: 'صورتك مع البطاقة أمام وجهك', icon: Icons.face_rounded),
  ];

  int get _uploadedVehicle => _vehiclePhotos.where((p) => p.uploaded).length;
  int get _uploadedId => _idPhotos.where((p) => p.uploaded).length;

  void _togglePhoto(List<_PhotoSlot> list, int index) {
    setState(() => list[index].uploaded = !list[index].uploaded);
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
        child: Column(
          children: [
            // ── الهيدر ────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  MshwarCardButton(
                    onTap: () => Navigator.pop(context),
                    backgroundColor: surface,
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back_rounded, size: 24, color: tp),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: Text('إنشاء حساب كابتن', style: AppTypography.displayLarge(tp))),
                ],
              ),
            ),

            // ── قائمة الحقول والصور ───────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 200),
                children: [
                  // ════════════════════════════════════
                  // 1. البيانات الشخصية
                  // ════════════════════════════════════
                  _buildSectionHeader('1. البيانات الشخصية', tp),
                  _buildPhotoBox(
                    _PhotoSlot(key: 'selfie', label: 'الصورة الشخصية', hint: 'خلفية بيضاء، وجه واضح', icon: Icons.person_rounded, uploaded: false),
                    border, surface, tp,
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  _buildInputField('الاسم الكامل (رباعي)', 'محمد أحمد علي سالم', tp, border, surface),
                  const SizedBox(height: 32),

                  // ════════════════════════════════════
                  // 2. رخصة القيادة
                  // ════════════════════════════════════
                  _buildSectionHeader('2. رخصة القيادة', tp),
                  _buildPhotoBox(
                    _PhotoSlot(key: 'license', label: 'صورة رخصة القيادة', hint: 'الوجهَيْن في صورة واحدة إن أمكن', icon: Icons.badge_rounded, uploaded: false),
                    border, surface, tp,
                    onTap: () {},
                  ),
                  const SizedBox(height: 32),

                  // ════════════════════════════════════
                  // 3. الهوية الشخصية (3 صور)
                  // ════════════════════════════════════
                  _buildSectionHeader('3. البطاقة الشخصية (3 صور مطلوبة)', tp),
                  _buildProgressBar(_uploadedId, _idPhotos.length, AppColors.info, border),
                  const SizedBox(height: 16),
                  ..._idPhotos.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildPhotoBox(
                      entry.value,
                      border, surface, tp,
                      onTap: () => _togglePhoto(_idPhotos, entry.key),
                    ),
                  )),
                  const SizedBox(height: 32),

                  // ════════════════════════════════════
                  // 4. بيانات المركبة
                  // ════════════════════════════════════
                  _buildSectionHeader('4. بيانات المركبة', tp),
                  Row(
                    children: [
                      Expanded(child: _buildInputField('نوع السيارة', 'تويوتا، هيونداي..', tp, border, surface)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInputField('الموديل', 'كامري، إلنترا..', tp, border, surface)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildInputField('سنة الصنع', '2015', tp, border, surface, isNumber: true)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInputField('اللون', 'أبيض', tp, border, surface)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildInputField('رقم اللوحة', 'أ ب ج 1234', tp, border, surface),
                  const SizedBox(height: 32),

                  // ════════════════════════════════════
                  // 5. صور المركبة (5 صور)
                  // ════════════════════════════════════
                  _buildSectionHeader('5. صور المركبة (5 صور مطلوبة)', tp),
                  Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.15),
                      border: Border.all(color: AppColors.warning, width: 2),
                      borderRadius: AppDimens.r8,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded, color: AppColors.warning),
                        const SizedBox(width: 8),
                        Expanded(child: Text('يجب أن تكون السيارة نظيفة والصور خارجية في ضوء كافٍ', style: AppTypography.bodySmall(tp))),
                      ],
                    ),
                  ),
                  _buildProgressBar(_uploadedVehicle, _vehiclePhotos.length, AppColors.success, border),
                  const SizedBox(height: 16),
                  ..._vehiclePhotos.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildPhotoBox(
                      entry.value,
                      border, surface, tp,
                      onTap: () => _togglePhoto(_vehiclePhotos, entry.key),
                    ),
                  )),
                  const SizedBox(height: 32),

                  // ════════════════════════════════════
                  // 6. الموافقة على الشروط
                  // ════════════════════════════════════
                  MshwarCardButton(
                    onTap: () => setState(() => _agreed = !_agreed),
                    backgroundColor: _agreed ? AppColors.primary : surface,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(
                          _agreed ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                          color: _agreed ? Colors.black : ts,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'أوافق على الشروط والأحكام وسياسة الكباتن في مشوار',
                            style: AppTypography.titleMedium(tp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ── زر الإرسال العائم ─────────────────────────
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: MshwarButton(
          label: 'إرسال الطلب للمراجعة',
          icon: Icons.send_rounded,
          onPressed: () {
            if (!_agreed) {
              MshwarSnackbar.show(
                context: context,
                message: 'يجب الموافقة على الشروط والأحكام أولاً',
                type: SnackbarType.error,
              );
              return;
            }
            if (_uploadedVehicle < _vehiclePhotos.length) {
              MshwarSnackbar.show(
                context: context,
                message: 'يرجى رفع جميع صور المركبة (${_vehiclePhotos.length} صور)',
                type: SnackbarType.error,
              );
              return;
            }
            if (_uploadedId < _idPhotos.length) {
              MshwarSnackbar.show(
                context: context,
                message: 'يرجى رفع صور البطاقة الشخصية كاملة (${_idPhotos.length} صور)',
                type: SnackbarType.error,
              );
              return;
            }
            Navigator.push(context, MshwarPageRoute(builder: (_) => const PendingApprovalScreen()));
          },
        ),
      ),
    );
  }

  // ── ويدجت سيكشن هيدر ────────────────────────────
  Widget _buildSectionHeader(String title, Color tp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(width: 6, height: 24, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(title, style: AppTypography.titleLarge(tp)),
        ],
      ),
    );
  }

  // ── شريط التقدم ────────────────────────────────
  Widget _buildProgressBar(int uploaded, int total, Color color, Color border) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$uploaded / $total صور مرفوعة', style: AppTypography.bodySmall(color)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: uploaded == total ? AppColors.success : AppColors.warning,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Text(
                uploaded == total ? 'مكتمل ✓' : 'ناقص',
                style: AppTypography.labelLarge(Colors.black),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            border: Border.all(color: border, width: 2),
            borderRadius: BorderRadius.circular(2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: uploaded / total,
            child: Container(color: color),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ── صندوق رفع الصورة ───────────────────────────
  Widget _buildPhotoBox(_PhotoSlot slot, Color border, Color surface, Color tp, {required VoidCallback onTap}) {
    final isDone = slot.uploaded;
    return MshwarCardButton(
      onTap: onTap,
      backgroundColor: isDone ? AppColors.success.withOpacity(0.15) : surface,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: isDone ? AppColors.success : AppColors.primary,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: AppDimens.r8,
            ),
            child: Icon(
              isDone ? Icons.check_rounded : slot.icon,
              color: Colors.black,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(slot.label, style: AppTypography.titleLarge(tp)),
                const SizedBox(height: 4),
                Text(slot.hint, style: AppTypography.bodySmall(tp.withOpacity(0.6))),
              ],
            ),
          ),
          Icon(
            isDone ? Icons.check_circle_rounded : Icons.camera_alt_rounded,
            color: isDone ? AppColors.success : tp.withOpacity(0.4),
            size: 24,
          ),
        ],
      ),
    );
  }

  // ── حقل إدخال نص ───────────────────────────────
  Widget _buildInputField(String label, String hint, Color tp, Color border, Color surface, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.titleMedium(tp)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: surface,
            borderRadius: AppDimens.r8,
            border: Border.all(color: border, width: AppDimens.borderThick),
            boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
          ),
          child: TextField(
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            style: AppTypography.titleLarge(tp),
            decoration: InputDecoration(
              hintText: hint,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}
