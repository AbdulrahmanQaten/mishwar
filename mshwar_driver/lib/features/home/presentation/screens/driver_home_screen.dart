/// 🗺️ الشاشة الرئيسية للسائق (الخريطة والرادار) — Gumroad Style
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Size;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import '../../../ride/presentation/screens/active_ride_screen.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> with SingleTickerProviderStateMixin {
  MapboxMap? mapboxMap;
  bool _isOnline = false;
  bool _showIncomingRequest = false;
  late AnimationController _radarController;

  @override
  void initState() {
    super.initState();
    _radarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _radarController.dispose();
    super.dispose();
  }

  void _toggleOnline() {
    setState(() {
      _isOnline = !_isOnline;
      if (_isOnline) {
        _radarController.repeat();
        // محاكاة طلب جديد بعد 4 ثوانٍ
        Future.delayed(const Duration(seconds: 4), () {
          if (mounted && _isOnline) {
            setState(() => _showIncomingRequest = true);
          }
        });
      } else {
        _radarController.stop();
        _showIncomingRequest = false;
      }
    });
  }

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    mapboxMap.compass.updateSettings(CompassSettings(enabled: false));
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg  = isDark ? AppColors.darkBg   : AppColors.lightBg;
    final border = isDark ? Colors.white : Colors.black;
    final tp  = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          // ── الخريطة ──────────────────────────────────
          Positioned.fill(
            child: kIsWeb
                ? _MapWidget(isDark: isDark)
                : MapWidget(
                    key: const ValueKey("driverMapWidget"),
                    onMapCreated: _onMapCreated,
                    styleUri: isDark ? MapboxStyles.DARK : MapboxStyles.LIGHT,
                    cameraOptions: CameraOptions(
                      center: Point(coordinates: Position(45.0355, 12.8306)),
                      zoom: 14.0,
                    ),
                  ),
          ),

          // ── تأثير الرادار عند الاتصال ────────────────
          if (_isOnline && !_showIncomingRequest)
            Center(
              child: AnimatedBuilder(
                animation: _radarController,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100 + (_radarController.value * 200),
                        height: 100 + (_radarController.value * 200),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withOpacity(1 - _radarController.value),
                            width: 8,
                          ),
                        ),
                      ),
                      Container(
                        width: 50 + (_radarController.value * 100),
                        height: 50 + (_radarController.value * 100),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity((1 - _radarController.value) * 0.5),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

          // ── زر "متاح للعمل" العائم (Brutalist Top Panel) ──
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            right: 20,
            child: MshwarCardButton(
              onTap: _toggleOnline,
              backgroundColor: _isOnline ? AppColors.error : AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_isOnline ? Icons.power_settings_new_rounded : Icons.wifi_tethering_rounded, 
                       color: Colors.black, size: 32),
                  const SizedBox(width: 12),
                  Text(
                    _isOnline ? 'إيقاف العمل' : 'اذهب للعمل',
                    style: AppTypography.displayLarge(Colors.black),
                  ),
                ],
              ),
            ),
          ),

          // ── نافذة الطلب الجديد (Incoming Request) ──
          if (_showIncomingRequest)
            Positioned(
              left: 20,
              right: 20,
              bottom: 120, // فوق البار السفلي
              child: _buildIncomingRequestModal(isDark, border, tp),
            ),
        ],
      ),
    );
  }

  Widget _buildIncomingRequestModal(bool isDark, Color border, Color tp) {
    final bg = isDark ? AppColors.darkBg : AppColors.lightBg;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: AppDimens.r8,
        border: Border.all(color: Colors.black, width: 4),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(8, 8))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // ── شريط الوقت المتناقص ────────────────────
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              duration: const Duration(seconds: 15),
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Container(
                      height: 10,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.15),
                    ),
                    FractionallySizedBox(
                      widthFactor: value,
                      child: Container(height: 10, color: AppColors.error),
                    ),
                  ],
                );
              },
              onEnd: () => setState(() => _showIncomingRequest = false),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── عنوان + السعر ───────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('طلب جديد!',
                              style: AppTypography.displayLarge(Colors.black)
                                  .copyWith(fontSize: 28, letterSpacing: -1))
                              .animate().shake(duration: 300.ms),
                          const SizedBox(height: 6),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                color: Colors.black,
                                child: Text('المسافة: 1.2 كم',
                                    style: AppTypography.labelLarge(AppColors.primary)),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                color: Colors.black.withOpacity(0.1),
                                child: Text('≈ 3 دقائق',
                                    style: AppTypography.labelLarge(Colors.black)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('السعر',
                            style: AppTypography.bodySmall(Colors.black54)),
                        Text('1200 ر.ي',
                            style: AppTypography.displayLarge(Colors.black)
                                .copyWith(fontSize: 36)),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ── بطاقة المسار ───────────────────────────
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: bg,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 14, height: 14,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('نقطة الانطلاق',
                                    style: AppTypography.bodySmall(tp.withOpacity(0.5))),
                                Text('جولة كالتكس، المنصورة',
                                    style: AppTypography.titleMedium(tp)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 6, top: 6, bottom: 6),
                        width: 2, height: 20,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 14, height: 14,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('الوجهة',
                                    style: AppTypography.bodySmall(tp.withOpacity(0.5))),
                                Text('كريتر، عدن مول',
                                    style: AppTypography.titleMedium(tp)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ── أزرار الرفض والقبول ──────────────────
                Row(
                  children: [
                    // زر رفض (صغير)
                    MshwarCardButton(
                      onTap: () => setState(() => _showIncomingRequest = false),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.close_rounded, color: Colors.black, size: 22),
                          const SizedBox(width: 6),
                          Text('رفض', style: AppTypography.titleLarge(Colors.black)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // زر قبول (كبير)
                    Expanded(
                      child: MshwarCardButton(
                        onTap: () {
                          setState(() => _showIncomingRequest = false);
                          Navigator.push(context,
                              MshwarPageRoute(builder: (_) => const ActiveRideScreen()));
                        },
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.check_rounded, color: AppColors.primary, size: 24),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'قبول الطلب',
                                style: AppTypography.titleLarge(AppColors.primary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 1.0, end: 0, duration: 400.ms, curve: Curves.easeOutBack);
  }
}

// رسم الخريطة الوهمية للويب
class _MapWidget extends StatelessWidget {
  final bool isDark;
  const _MapWidget({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CleanMapPainter(isDark: isDark),
      child: const SizedBox.expand(),
    );
  }
}

class _CleanMapPainter extends CustomPainter {
  final bool isDark;
  const _CleanMapPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final bg = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF2F2F0);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = bg);

    final road = Paint()
      ..color = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFFFFFF)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.square;

    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), road);
    canvas.drawLine(Offset(0, size.height * 0.6), Offset(size.width, size.height * 0.6), road);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.4, size.height), road);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.7, size.height), road);

    final px = size.width * 0.4;
    final py = size.height * 0.45;
    
    // موقع السائق كمربع بروتالي
    canvas.drawRect(
      Rect.fromCenter(center: Offset(px, py), width: 32, height: 32),
      Paint()..color = Colors.black,
    );
    canvas.drawRect(
      Rect.fromCenter(center: Offset(px, py), width: 16, height: 16),
      Paint()..color = AppColors.primary,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
