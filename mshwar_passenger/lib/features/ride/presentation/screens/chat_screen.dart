/// 💬 المحادثة مع الكابتن — Gumroad Style
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/mshwar_card_button.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg  = isDark ? AppColors.darkBg   : AppColors.lightBg;
    final tp  = isDark ? AppColors.darkTextPrimary   : AppColors.lightTextPrimary;
    final ts  = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final border = isDark ? Colors.white : Colors.black;
    final surface = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surface,
                border: Border(bottom: BorderSide(color: border, width: AppDimens.borderThick)),
              ),
              child: Row(
                children: [
                  MshwarCardButton(
                    onTap: () => Navigator.pop(context),
                    backgroundColor: bg,
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back_rounded, size: 24, color: tp),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.info,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: const Icon(Icons.person_rounded, size: 32, color: Colors.black),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الكابتن محمود', style: AppTypography.titleLarge(tp)),
                        Text('تويوتا كامري • ABC 123', style: AppTypography.labelLarge(ts)),
                      ],
                    ),
                  ),
                  MshwarCardButton(
                    onTap: () {},
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.all(12),
                    child: const Icon(Icons.phone_rounded, color: Colors.black),
                  ),
                ],
              ),
            ),
            
            // Messages
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildMessage('مرحباً، أنا في طريقي إليك', '10:42 ص', false, border, surface, tp, ts),
                  _buildMessage('أهلاً بك، أنا أنتظر عند المدخل الرئيسي', '10:43 ص', true, border, surface, tp, ts),
                  _buildMessage('تمام، سأكون عندك خلال دقيقتين', '10:44 ص', false, border, surface, tp, ts),
                ],
              ),
            ),
            
            // Input
            Container(
              padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
              decoration: BoxDecoration(
                color: surface,
                border: Border(top: BorderSide(color: border, width: AppDimens.borderThick)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkBg : AppColors.lightBg,
                        borderRadius: AppDimens.r8,
                        border: Border.all(color: border, width: AppDimens.borderThick),
                      ),
                      child: TextField(
                        style: AppTypography.titleMedium(tp),
                        decoration: InputDecoration(
                          hintText: 'اكتب رسالة...',
                          hintStyle: AppTypography.titleMedium(ts),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  MshwarCardButton(
                    onTap: () {},
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.all(14),
                    child: const Icon(Icons.send_rounded, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(String text, String time, bool isMe, Color border, Color surface, Color tp, Color ts) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: AppColors.info,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const Icon(Icons.person_rounded, size: 20, color: Colors.black),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : surface,
                borderRadius: AppDimens.r8,
                border: Border.all(color: border, width: AppDimens.borderThick),
                boxShadow: [BoxShadow(color: border, offset: const Offset(4, 4))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(text, style: AppTypography.titleMedium(isMe ? Colors.black : tp)),
                  const SizedBox(height: 4),
                  Text(time, style: AppTypography.labelLarge(isMe ? Colors.black54 : ts).copyWith(fontSize: 10)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
