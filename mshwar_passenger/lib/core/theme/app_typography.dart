/// 🔤 الطباعة — Gumroad Style (Neo-brutalism)
/// خطوط عريضة جداً، تباين عالي، وزن ثقيل

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextStyle displayLarge(Color color) => GoogleFonts.cairo(
        fontSize: 32, fontWeight: FontWeight.w900, color: color,
        height: 1.2, letterSpacing: -0.5);

  static TextStyle headlineLarge(Color color) => GoogleFonts.cairo(
        fontSize: 26, fontWeight: FontWeight.w900, color: color,
        height: 1.25, letterSpacing: -0.3);

  static TextStyle headlineMedium(Color color) => GoogleFonts.cairo(
        fontSize: 22, fontWeight: FontWeight.w800, color: color,
        height: 1.3);

  static TextStyle titleLarge(Color color) => GoogleFonts.cairo(
        fontSize: 18, fontWeight: FontWeight.w800, color: color,
        height: 1.35);

  static TextStyle titleMedium(Color color) => GoogleFonts.cairo(
        fontSize: 16, fontWeight: FontWeight.w700, color: color,
        height: 1.4);

  static TextStyle bodyLarge(Color color) => GoogleFonts.cairo(
        fontSize: 16, fontWeight: FontWeight.w600, color: color,
        height: 1.5);

  static TextStyle bodyMedium(Color color) => GoogleFonts.cairo(
        fontSize: 14, fontWeight: FontWeight.w600, color: color,
        height: 1.5);

  static TextStyle bodySmall(Color color) => GoogleFonts.cairo(
        fontSize: 13, fontWeight: FontWeight.w500, color: color,
        height: 1.4);

  static TextStyle labelLarge(Color color) => GoogleFonts.cairo(
        fontSize: 14, fontWeight: FontWeight.w800, color: color,
        letterSpacing: 0.5, height: 1.3);

  static TextStyle buttonLarge(Color color) => GoogleFonts.cairo(
        fontSize: 16, fontWeight: FontWeight.w900, color: color,
        height: 1.2);

  static TextStyle buttonMedium(Color color) => GoogleFonts.cairo(
        fontSize: 14, fontWeight: FontWeight.w800, color: color,
        height: 1.2);

  static TextStyle priceDisplay(Color color) => GoogleFonts.cairo(
        fontSize: 28, fontWeight: FontWeight.w900, color: color,
        height: 1.1, letterSpacing: -0.5);
}
