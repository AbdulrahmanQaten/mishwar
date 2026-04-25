/// 📐 القياسات — Gumroad Style (Neo-brutalism)
/// حواف سميكة جداً، زوايا مستطيلة تقريباً، وظلال صلبة مزاحة

import 'package:flutter/material.dart';

class AppDimens {
  AppDimens._();

  static const xs  = 4.0;
  static const sm  = 8.0;
  static const md  = 16.0;
  static const lg  = 24.0;
  static const xl  = 32.0;

  // ── Border & Radius ───────────────────────
  static const double borderThick = 3.0; // الإطار البروتالي العريض
  static const double borderThin  = 1.5;

  // زوايا حادة تماماً (Brutalism 100%)
  static const r4  = BorderRadius.zero;
  static const r8  = BorderRadius.zero;
  
  static const roundedSm   = BorderRadius.zero;
  static const roundedMd   = BorderRadius.zero;
  static const roundedLg   = BorderRadius.zero;
  static const roundedXl   = BorderRadius.zero; 
  static const roundedFull = BorderRadius.all(Radius.circular(999)); // فقط للدوائر الحقيقية
  
  static const bottomSheetRadius = BorderRadius.zero;

  static const durationFast   = Duration(milliseconds: 100);
  static const durationNormal = Duration(milliseconds: 200);

  static const buttonHeight  = 56.0;
  static const pagePadding = EdgeInsets.symmetric(horizontal: 20, vertical: 0);
}

/// ظلال النيو-بروتاليزم الصلبة (Offset بدون Blur)
class AppShadows {
  AppShadows._();

  // الظل البروتالي: مزاح بـ X و Y، ولونه أسود نقي تماماً بدون أي تغبيش
  static const solidBrutalist = <BoxShadow>[
    BoxShadow(
      color: Colors.black, 
      blurRadius: 0,
      spreadRadius: 0,
      offset: Offset(4, 4),
    ),
  ];

  static const solidBrutalistSm = <BoxShadow>[
    BoxShadow(
      color: Colors.black, 
      blurRadius: 0,
      spreadRadius: 0,
      offset: Offset(2, 2),
    ),
  ];

  static const cardLight     = solidBrutalist;
  static const cardDark      = solidBrutalist;
  static const bottomSheet   = solidBrutalist;
  static const fab           = solidBrutalist;
  static const primaryGlowSm = solidBrutalistSm; // Fallback alias
}
