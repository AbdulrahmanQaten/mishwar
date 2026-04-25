/// 🔘 بطاقة ميكانيكية (Card Button) — Gumroad Style
/// زر ميكانيكي مرن يمكن وضع أي محتوى بداخله (يدخل في الظل عند الضغط)

import 'package:flutter/material.dart';
import '../../core/theme/app_dimens.dart';

class MshwarCardButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool isCircle;

  const MshwarCardButton({
    super.key,
    required this.child,
    required this.onTap,
    required this.backgroundColor,
    this.padding,
    this.margin,
    this.isCircle = false,
  });

  @override
  State<MshwarCardButton> createState() => _MshwarCardButtonState();
}

class _MshwarCardButtonState extends State<MshwarCardButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) => setState(() => _isPressed = true);
  
  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap();
  }
  
  void _handleTapCancel() => setState(() => _isPressed = false);

  @override
  Widget build(BuildContext context) {
    final shadowColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;
    final shadowOffset = _isPressed ? 0.0 : 4.0;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: widget.margin != null 
          ? widget.margin!.add(EdgeInsets.only(
              top: _isPressed ? 4.0 : 0.0, 
              left: _isPressed ? 4.0 : 0.0, 
              bottom: _isPressed ? 0.0 : 4.0, 
              right: _isPressed ? 0.0 : 4.0))
          : EdgeInsets.only(
              top: _isPressed ? 4.0 : 0.0, 
              left: _isPressed ? 4.0 : 0.0, 
              bottom: _isPressed ? 0.0 : 4.0, 
              right: _isPressed ? 0.0 : 4.0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          shape: widget.isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: widget.isCircle ? null : AppDimens.r8,
          border: Border.all(color: shadowColor, width: AppDimens.borderThick),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(shadowOffset, shadowOffset),
              blurRadius: 0,
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
