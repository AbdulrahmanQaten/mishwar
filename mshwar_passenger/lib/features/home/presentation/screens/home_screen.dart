/// 🏠 الشاشة الرئيسية — Gumroad Style (Neo-brutalism)

import 'package:flutter/material.dart';
import '../../../../core/routes/mshwar_page_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' hide Size;
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../ride/presentation/screens/destination_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MapboxMap? mapboxMap;

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
                    key: const ValueKey("mapWidget"),
                    onMapCreated: _onMapCreated,
                    styleUri: isDark ? MapboxStyles.DARK : MapboxStyles.LIGHT,
                    cameraOptions: CameraOptions(
                      center: Point(coordinates: Position(45.0355, 12.8306)),
                      zoom: 14.0,
                    ),
                  ),
          ),
          
          // زر القائمة العائم بستايل بروتالي
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const ProfileScreen())),
              child: Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  borderRadius: AppDimens.r8,
                  border: Border.all(color: border, width: AppDimens.borderThick),
                  boxShadow: [
                    BoxShadow(color: border, offset: const Offset(4, 4), blurRadius: 0),
                  ],
                ),
                child: Icon(Icons.menu_rounded, color: isDark ? Colors.white : Colors.black),
              ),
            ),
          ),

          // ── لوحة البحث العائمة (Gumroad Box) ────────
          Positioned(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom + 100, // مرفوع فوق شريط التنقل
            child: _buildBottomPanel(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPanel(bool isDark) {
    final tp   = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final border = isDark ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: AppDimens.r8,
        border: Border.all(color: border, width: AppDimens.borderThick),
        boxShadow: [
          BoxShadow(color: border, offset: const Offset(4, 4), blurRadius: 0),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // شريط البحث الممتلئ بحدود سميكة
          GestureDetector(
            onTap: () => Navigator.push(context, MshwarPageRoute(builder: (_) => const DestinationScreen())),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBg : AppColors.lightBg,
                borderRadius: AppDimens.r8,
                border: Border.all(color: border, width: AppDimens.borderThick),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, size: 28, color: tp),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text('إلى أين؟', style: AppTypography.titleLarge(tp)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppDimens.r4,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Text('الآن', style: AppTypography.labelLarge(Colors.black)),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              _buildPlaceShortcut(Icons.home_rounded, 'المنزل', isDark, tp, border),
              const SizedBox(width: 16),
              _buildPlaceShortcut(Icons.work_rounded, 'العمل', isDark, tp, border),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceShortcut(IconData icon, String label, bool isDark, Color tp, Color border) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBg : AppColors.lightBg,
          borderRadius: AppDimens.r8,
          border: Border.all(color: border, width: AppDimens.borderThick),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: tp),
            const SizedBox(width: 8),
            Text(label, style: AppTypography.titleMedium(tp)),
          ],
        ),
      ),
    );
  }
}

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
      ..strokeCap = StrokeCap.square; // حواف مربعة لتناسب النيو-بروتاليزم

    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), road);
    canvas.drawLine(Offset(0, size.height * 0.6), Offset(size.width, size.height * 0.6), road);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.4, size.height), road);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.7, size.height), road);

    final px = size.width * 0.4;
    final py = size.height * 0.45;
    
    // موقع المستخدم كمربع بروتالي
    canvas.drawRect(
      Rect.fromCenter(center: Offset(px, py), width: 24, height: 24),
      Paint()..color = isDark ? Colors.white : Colors.black,
    );
    canvas.drawRect(
      Rect.fromCenter(center: Offset(px, py), width: 12, height: 12),
      Paint()..color = AppColors.primary,
    );
  }

  @override
  bool shouldRepaint(_) => false;
}
