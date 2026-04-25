import 'package:flutter/material.dart';

/// انتقال صفحات صلب (Brutalist Route) — ينزلق بسرعة وبدون تلاشي
class MshwarPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  MshwarPageRoute({required this.builder})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // انزلاق من اليمين إلى اليسار (بدون تلاشي Fade)
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            // منحنى حركة حاد جداً (Decelerate) يعطي انطباعاً ميكانيكياً
            const curve = Curves.easeOutExpo;

            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
