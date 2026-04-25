/// 🔘 زر مشوار — Gumroad Style (Neo-brutalism)
/// زر ميكانيكي ممتع، بحدود سميكة وظل صلب يتحرك عند الضغط.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_dimens.dart';

enum MshwarButtonVariant { primary, secondary, danger }

class MshwarButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final MshwarButtonVariant variant;
  final IconData? icon;
  final double? width;

  const MshwarButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.variant = MshwarButtonVariant.primary,
    this.icon,
    this.width,
  });

  @override
  State<MshwarButton> createState() => _MshwarButtonState();
}

class _MshwarButtonState extends State<MshwarButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isLoading && widget.onPressed != null) {
      setState(() => _isPressed = true);
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isLoading && widget.onPressed != null) {
      setState(() => _isPressed = false);
      widget.onPressed!();
    }
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color bgColor;
    Color fgColor;
    
    switch (widget.variant) {
      case MshwarButtonVariant.primary:
        bgColor = AppColors.primary;
        fgColor = AppColors.primaryFg;
        break;
      case MshwarButtonVariant.secondary:
        bgColor = isDark ? Colors.black : Colors.white;
        fgColor = isDark ? Colors.white : Colors.black;
        break;
      case MshwarButtonVariant.danger:
        bgColor = AppColors.error;
        fgColor = Colors.black;
        break;
    }

    final isDisabled = widget.onPressed == null && !widget.isLoading;
    if (isDisabled) {
      bgColor = isDark ? const Color(0xFF333333) : const Color(0xFFEEEEEE);
      fgColor = isDark ? const Color(0xFF777777) : const Color(0xFFAAAAAA);
    }

    // الظل الصلب للبروتاليزم
    final shadowColor = isDark ? Colors.white : Colors.black;
    final shadowOffset = _isPressed ? 0.0 : 4.0;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: AppDimens.durationFast,
        width: widget.width ?? double.infinity,
        height: AppDimens.buttonHeight,
        margin: EdgeInsets.only(
          top: _isPressed ? 4.0 : 0.0,
          left: _isPressed ? 4.0 : 0.0,
          bottom: _isPressed ? 0.0 : 4.0,
          right: _isPressed ? 0.0 : 4.0,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppDimens.r8,
          border: Border.all(
            color: shadowColor, 
            width: AppDimens.borderThick
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(shadowOffset, shadowOffset),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: widget.isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, color: fgColor, size: 22),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: AppTypography.buttonLarge(fgColor),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
