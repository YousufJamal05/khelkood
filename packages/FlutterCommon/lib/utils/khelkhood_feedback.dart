import 'package:flutter/material.dart';

enum KhelKhoodFeedbackType { success, error }

class KhelKhoodFeedback extends StatelessWidget {
  final String title;
  final String message;
  final KhelKhoodFeedbackType type;
  final VoidCallback? onClose;

  const KhelKhoodFeedback({
    super.key,
    required this.title,
    required this.message,
    required this.type,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSuccess = type == KhelKhoodFeedbackType.success;
    final Color accentColor =
        isSuccess ? const Color(0xFF4CAF50) : const Color(0xFFD32F2F);
    final Color iconBgColor =
        isSuccess ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
    final IconData icon = isSuccess ? Icons.check_circle : Icons.error;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Left Accent Border
            Container(
              width: 8,
              color: accentColor,
            ),
            const SizedBox(width: 16),
            // Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: accentColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (onClose != null)
              IconButton(
                icon:
                    const Icon(Icons.close, size: 20, color: Color(0xFF9CA3AF)),
                onPressed: onClose,
              ),
            if (onClose == null) const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
