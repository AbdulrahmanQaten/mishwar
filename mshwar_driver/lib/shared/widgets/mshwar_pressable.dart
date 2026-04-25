/// 🔘 الغلاف الميكانيكي (Pressable Wrapper) — Gumroad Style
/// يقوم بتغليف أي عنصر ليجعله قابلاً للضغط كزر بروتالي (ينخفض للأسفل 4px)

import 'package:flutter/material.dart';

class MshwarPressable extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const MshwarPressable({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<MshwarPressable> createState() => _MshwarPressableState();
}

class _MshwarPressableState extends State<MshwarPressable> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) => setState(() => _isPressed = true);
  
  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap();
  }
  
  void _handleTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: EdgeInsets.only(
          top: _isPressed ? 4.0 : 0.0,
          left: _isPressed ? 4.0 : 0.0,
          bottom: _isPressed ? 0.0 : 4.0,
          right: _isPressed ? 0.0 : 4.0,
        ),
        child: widget.child,
      ),
    );
  }
}
