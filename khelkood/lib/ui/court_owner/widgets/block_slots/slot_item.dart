import 'package:flutter/material.dart';
import '../../../../design/app_colors.dart';

class SlotItem extends StatelessWidget {
  final String slot;
  final String status;
  final bool isSelected;
  final bool isDark;
  final VoidCallback? onTap;

  const SlotItem({
    super.key,
    required this.slot,
    required this.status,
    required this.isSelected,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    String? subLabel;

    if (status == 'booked') {
      bgColor = isDark ? Colors.grey.shade800 : Colors.grey.shade100;
      textColor = Colors.grey;
      subLabel = 'Booked';
    } else if (status == 'blocked') {
      bgColor = Colors.red.withOpacity(0.1);
      textColor = Colors.red;
      subLabel = 'Blocked';
    } else if (isSelected) {
      bgColor = AppColors.primary;
      textColor = Colors.white;
      subLabel = 'Selected';
    } else {
      bgColor = isDark ? AppColors.surfaceDark : Colors.white;
      textColor = isDark ? Colors.white : Colors.black87;
      subLabel = 'PKR 2000';
    }

    return GestureDetector(
      onTap: status == 'available' ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(32),
          border: status == 'available' && !isSelected
              ? Border.all(color: Colors.grey.shade100, width: 1.5)
              : Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? AppColors.borderDark : Colors.transparent),
                  width: 1,
                ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Stack(
          children: [
            if (isSelected)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 8,
                    color: AppColors.primary,
                  ),
                ),
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    slot,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textColor,
                      decoration: status == 'booked'
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  Text(
                    subLabel,
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected
                          ? Colors.white70
                          : (status == 'booked'
                                ? Colors.grey
                                : AppColors.primary.withOpacity(0.8)),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
