/// 🚗 شاشة الرحلة الفعالة (السائق) — Gumroad Style
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Size;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';
import '../../../../shared/widgets/mshwar_button.dart';

enum RideStatus { goingToPickup, waiting, inTransit, finished }

class ActiveRideScreen extends StatefulWidget {
  const ActiveRideScreen({super.key});

  @override
  State<ActiveRideScreen> createState() => _ActiveRideScreenState();
}

class _ActiveRideScreenState extends State<ActiveRideScreen> {
  MapboxMap? mapboxMap;
  RideStatus _status = RideStatus.goingToPickup;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    mapboxMap.compass.updateSettings(CompassSettings(enabled: false));
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
  }

  Future<void> _openGoogleMapsNavigation() async {
    // إحداثيات وهمية للراكب
    final Uri googleMapsUrl = Uri.parse("google.navigation:q=12.8306,45.0355&mode=d");
    final Uri webUrl = Uri.parse("https://www.google.com/maps/dir/?api=1&destination=12.8306,45.0355&travelmode=driving");
    
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      await launchUrl(webUrl);
    }
  }

  void _nextStatus() {
    setState(() {
      if (_status == RideStatus.goingToPickup) {
        _status = RideStatus.waiting;
      } else if (_status == RideStatus.waiting) {
        _status = RideStatus.inTransit;
      } else if (_status == RideStatus.inTransit) {
        _status = RideStatus.finished;
        _showReceiptModal();
      }
    });
  }

  void _showReceiptModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBg : AppColors.lightBg,
            borderRadius: AppDimens.bottomSheetRadius,
            border: Border.all(color: Colors.black, width: 4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('تمت الرحلة بنجاح!', style: AppTypography.displayLarge(isDark ? Colors.white : Colors.black)),
              const SizedBox(height: 24),
              Text('المبلغ المطلوب تحصيله', style: AppTypography.titleLarge(isDark ? Colors.white54 : Colors.black54)),
              Text('1500 ر.ي', style: AppTypography.displayLarge(AppColors.primary).copyWith(fontSize: 48)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.warning, border: Border.all(color: Colors.black, width: 2)),
                child: Text('الدفع: نقداً', style: AppTypography.titleLarge(Colors.black)),
              ),
              const SizedBox(height: 48),
              MshwarButton(
                label: 'إنهاء والعودة للرئيسية',
                icon: Icons.check_circle_rounded,
                onPressed: () {
                  Navigator.pop(context); // إغلاق المودال
                  Navigator.pop(context); // العودة للخريطة
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg  = isDark ? AppColors.darkBg   : AppColors.lightBg;
    final border = isDark ? Colors.white : Colors.black;
    final tp  = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

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
                    onMapCreated: _onMapCreated,
                    styleUri: isDark ? MapboxStyles.DARK : MapboxStyles.LIGHT,
                    cameraOptions: CameraOptions(
                      center: Point(coordinates: Position(45.0355, 12.8306)),
                      zoom: 14.0,
                    ),
                  ),
          ),

          // ── تفاصيل الراكب (Header) ────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: AppDimens.r8,
                border: Border.all(color: border, width: AppDimens.borderThick),
                boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(color: AppColors.info, border: Border.all(color: Colors.black, width: 2)),
                    child: const Icon(Icons.person_rounded, size: 32, color: Colors.black),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('أحمد محمد', style: AppTypography.titleLarge(tp)),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded, color: AppColors.warning, size: 16),
                            const SizedBox(width: 4),
                            Text('4.9', style: AppTypography.bodySmall(tp)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MshwarCardButton(
                    onTap: () {},
                    backgroundColor: AppColors.success,
                    padding: const EdgeInsets.all(12),
                    isCircle: true,
                    child: const Icon(Icons.phone_rounded, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),

          // ── لوحة التحكم السفلية (Footer) ────────────────
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: AppDimens.bottomSheetRadius,
                border: Border(top: BorderSide(color: border, width: AppDimens.borderThick)),
                boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(0, -4))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _status == RideStatus.goingToPickup ? 'الذهاب للراكب' :
                            _status == RideStatus.waiting ? 'في انتظار الراكب' : 'الرحلة جارية',
                            style: AppTypography.titleLarge(tp),
                          ),
                          Text('الوقت المتبقي: 3 دقائق', style: AppTypography.titleMedium(isDark ? Colors.white54 : Colors.black54)),
                        ],
                      ),
                      
                      // زر الملاحة عبر خرائط جوجل
                      MshwarCardButton(
                        onTap: _openGoogleMapsNavigation,
                        backgroundColor: AppColors.info,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            const Icon(Icons.navigation_rounded, color: Colors.black),
                            const SizedBox(width: 8),
                            Text('ملاحة', style: AppTypography.titleLarge(Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // زر تغيير الحالة
                  MshwarButton(
                    label: _status == RideStatus.goingToPickup ? 'وصلت لموقع الراكب' :
                           _status == RideStatus.waiting ? 'بدء الرحلة' : 'إنهاء الرحلة وتحصيل المبلغ',
                    icon: _status == RideStatus.finished ? Icons.payments_rounded : Icons.arrow_forward_rounded,
                    variant: _status == RideStatus.inTransit ? MshwarButtonVariant.danger : MshwarButtonVariant.primary,
                    onPressed: _nextStatus,
                  ),
                  
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
    
    // مسار للراكب
    canvas.drawLine(Offset(px, py), Offset(px + 100, py - 100), Paint()..color = AppColors.primary..strokeWidth = 6..style = PaintingStyle.stroke);

    // موقع السائق
    canvas.drawRect(Rect.fromCenter(center: Offset(px, py), width: 24, height: 24), Paint()..color = Colors.black);
    // موقع الراكب
    canvas.drawRect(Rect.fromCenter(center: Offset(px + 100, py - 100), width: 24, height: 24), Paint()..color = AppColors.info);
  }

  @override
  bool shouldRepaint(_) => false;
}
