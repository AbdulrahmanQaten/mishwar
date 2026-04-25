/// 🔔 إشعار مخصص (Snackbar) — Gumroad Style (Neo-brutalism)
/// صندوق عائم بحدود سميكة وظل صلب.

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_dimens.dart';

enum SnackbarType { success, error, info }

class MshwarSnackbar {
  static void show({
    required BuildContext context,
    required String message,
    SnackbarType type = SnackbarType.info,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? Colors.white : Colors.black;

    Color bgColor;
    Color iconColor = Colors.black;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        bgColor = AppColors.success;
        icon = Icons.check_circle_rounded;
        break;
      case SnackbarType.error:
        bgColor = AppColors.error;
        icon = Icons.error_rounded;
        break;
      case SnackbarType.info:
      default:
        bgColor = AppColors.info;
        icon = Icons.info_rounded;
        break;
    }

    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      duration: const Duration(seconds: 3),
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppDimens.r8,
          border: Border.all(color: borderColor, width: AppDimens.borderThick),
          boxShadow: [
            BoxShadow(
              color: borderColor,
              offset: const Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTypography.titleMedium(iconColor),
              ),
            ),
          ],
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
