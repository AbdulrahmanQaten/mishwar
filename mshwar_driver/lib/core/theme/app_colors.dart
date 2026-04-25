/// 🎨 نظام الألوان — Gumroad Style (Neo-brutalism)
/// ألوان فاقعة، تباين عالي، لا تدرجات

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary      = Color(0xFFFFE169); // أصفر بروتالي مميز لتطبيق السائق
  static const primaryHover = Color(0xFFFFD54F);
  static const primaryFg    = Color(0xFF000000);

  // ألوان الأساس
  static const bgLight      = Color(0xFFFBFBFB); // أبيض مكسور قليلاً جداً
  static const bgDark       = Color(0xFF1E1E1E); 
  static const surfaceLight = Color(0xFFFFFFFF);
  static const surfaceDark  = Color(0xFF2C2C2C);
  
  static const borderDark   = Color(0xFF000000); // حدود سوداء نقية للبروتاليزم
  static const borderLight  = Color(0xFFFFFFFF); 

  // النصوص
  static const textPrimaryLight   = Color(0xFF000000);
  static const textSecondaryLight = Color(0xFF4A4A4A);
  static const textHintLight      = Color(0xFF9E9E9E);

  static const textPrimaryDark    = Color(0xFFFFFFFF);
  static const textSecondaryDark  = Color(0xFFB3B3B3);
  static const textHintDark       = Color(0xFF757575);

  // دلالية (ألوان بروتالية قوية)
  static const success = Color(0xFF8DE8B1);
  static const error   = Color(0xFFFF9494);
  static const warning = Color(0xFFC7F2A4); // نستخدم الأخضر القديم للتحذيرات
  static const info    = Color(0xFF94D8FF);

  // Aliases
  static const lightBg = bgLight;
  static const darkBg  = bgDark;
  static const lightTextPrimary = textPrimaryLight;
  static const darkTextPrimary  = textPrimaryDark;
  static const lightTextSecondary = textSecondaryLight;
  static const darkTextSecondary  = textSecondaryDark;
  static const lightBorder = borderDark;
  static const darkBorder = borderLight;
  static const lightInputFill = surfaceLight;
  static const darkInputFill = surfaceDark;
  static const lightDivider = borderDark;
  static const darkDivider = borderLight;

  // Aliases for older screens (ride_options, rating, etc.)
  static const lightSurface = surfaceLight;
  static const darkSurface  = surfaceDark;
  static const lightCard    = surfaceLight;
  static const darkCard     = surfaceDark;
  static const primaryLight = primaryHover;
  static const primaryDark  = primary;
  static const starFilled   = warning;
  static const starEmpty    = textHintLight;
  static const lightTextHint = textHintLight;
  static const darkTextHint = textHintDark;
}
