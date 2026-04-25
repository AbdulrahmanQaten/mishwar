/// 🎨 الثيم — Gumroad Style (Neo-brutalism)
/// حدود سوداء سميكة، ظلال صلبة، وتصميم جريء

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_dimens.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark  => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final bg     = isDark ? AppColors.darkBg      : AppColors.lightBg;
    final surface= isDark ? AppColors.darkInputFill : AppColors.lightInputFill;
    final border = isDark ? AppColors.darkBorder  : AppColors.lightBorder;
    final textP  = isDark ? AppColors.darkTextPrimary   : AppColors.lightTextPrimary;
    final textS  = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final hint   = isDark ? AppColors.darkTextHint      : AppColors.lightTextHint;

    final base = GoogleFonts.cairoTextTheme().copyWith(
      bodyLarge:   GoogleFonts.cairo(color: textP, fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium:  GoogleFonts.cairo(color: textP, fontSize: 14, fontWeight: FontWeight.w600),
      bodySmall:   GoogleFonts.cairo(color: textS, fontSize: 13, fontWeight: FontWeight.w500),
      titleLarge:  GoogleFonts.cairo(color: textP, fontSize: 18, fontWeight: FontWeight.w800),
      titleMedium: GoogleFonts.cairo(color: textP, fontSize: 16, fontWeight: FontWeight.w700),
      titleSmall:  GoogleFonts.cairo(color: textS, fontSize: 14, fontWeight: FontWeight.w600),
      labelLarge:  GoogleFonts.cairo(color: textP, fontSize: 14, fontWeight: FontWeight.w800),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary:          AppColors.primary,
        onPrimary:        AppColors.primaryFg,
        primaryContainer: AppColors.primaryHover,
        onPrimaryContainer: AppColors.primaryFg,
        secondary:        AppColors.primary,
        onSecondary:      AppColors.primaryFg,
        secondaryContainer: AppColors.primaryHover,
        onSecondaryContainer: AppColors.primaryFg,
        surface:          surface,
        onSurface:        textP,
        error:            AppColors.error,
        onError:          Colors.black,
        outline:          border,
        outlineVariant:   border,
      ),
      scaffoldBackgroundColor: bg,
      textTheme: base,
      fontFamily: 'Cairo',

      // ── AppBar ──────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        foregroundColor: textP,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.cairo(
          color: textP, fontSize: 20, fontWeight: FontWeight.w900),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              isDark ? Brightness.light : Brightness.dark,
        ),
        iconTheme: IconThemeData(color: textP, size: 28),
      ),

      // ── InputDecoration (Brutalist Style: Thick Borders)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: AppDimens.r8,
          borderSide: BorderSide(color: border, width: AppDimens.borderThick),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppDimens.r8,
          borderSide: BorderSide(color: border, width: AppDimens.borderThick),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppDimens.r8,
          borderSide: BorderSide(color: AppColors.primary, width: AppDimens.borderThick), 
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppDimens.r8,
          borderSide: const BorderSide(color: AppColors.error, width: AppDimens.borderThick),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppDimens.r8,
          borderSide: const BorderSide(color: AppColors.error, width: AppDimens.borderThick),
        ),
        hintStyle: GoogleFonts.cairo(color: hint, fontSize: 15, fontWeight: FontWeight.w600),
        errorStyle: GoogleFonts.cairo(color: AppColors.error, fontSize: 13, fontWeight: FontWeight.w700),
        prefixIconColor: textP,
        suffixIconColor: textP,
      ),

      // ── BottomSheet ─────────────────────────
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimens.bottomSheetRadius,
          side: BorderSide(color: border, width: AppDimens.borderThick), // حدود سميكة للوحة السفلية
        ),
        elevation: 0,
        dragHandleColor: textP,
      ),

      // ── Card ────────────────────────────────
      cardTheme: CardTheme(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppDimens.r8,
          side: BorderSide(color: border, width: AppDimens.borderThick),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Divider ─────────────────────────────
      dividerTheme: DividerThemeData(
        color: border,
        thickness: AppDimens.borderThick, // فاصل عريض
        space: AppDimens.borderThick,
      ),
    );
  }
}
