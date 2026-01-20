import 'package:common/common.dart';
import 'package:flutter/material.dart';
import '../../../../design/app_colors.dart';
import '../../../../design/app_dimensions.dart';

class CourtDropdown extends StatelessWidget {
  final List<CourtModel> courts;
  final CourtModel? selectedCourt;
  final ValueChanged<CourtModel> onSelected;
  final bool isDark;

  const CourtDropdown({
    super.key,
    required this.courts,
    required this.selectedCourt,
    required this.onSelected,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return PopupMenuButton<CourtModel>(
            onSelected: onSelected,
            offset: const Offset(0, 70),
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: isDark ? AppColors.surfaceDark : Colors.white,
            elevation: 8,
            itemBuilder: (context) => courts
                .map(
                  (court) => PopupMenuItem<CourtModel>(
                    value: court,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        court.name,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontWeight: selectedCourt?.courtId == court.courtId
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingMD),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : Colors.grey.shade100,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.stadium_outlined,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Blocking for',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey : Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          selectedCourt?.name ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: isDark ? Colors.grey : Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
