import 'package:flutter/material.dart';
import '../../../../design/app_colors.dart';
import '../../../../design/app_dimensions.dart';

class ReasonSelector extends StatelessWidget {
  final List<String> reasons;
  final String selectedReason;
  final ValueChanged<String> onReasonSelected;
  final TextEditingController detailsController;
  final bool isDark;

  const ReasonSelector({
    super.key,
    required this.reasons,
    required this.selectedReason,
    required this.onReasonSelected,
    required this.detailsController,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLG),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reason for blocking',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: reasons
                .map(
                  (reason) => ChoiceChip(
                    label: Text(reason),
                    selected: selectedReason == reason,
                    onSelected: (selected) {
                      if (selected) onReasonSelected(reason);
                    },
                    backgroundColor: isDark
                        ? AppColors.surfaceDark
                        : Colors.white,
                    selectedColor: AppColors.primary.withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: selectedReason == reason
                          ? AppColors.primary
                          : (isDark ? Colors.white : Colors.black),
                      fontWeight: selectedReason == reason
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: selectedReason == reason
                            ? AppColors.primary
                            : (isDark
                                  ? AppColors.borderDark
                                  : Colors.grey.shade200),
                      ),
                    ),
                    showCheckmark: false,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: detailsController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Add specific details about the maintenance work...',
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              filled: true,
              fillColor: isDark
                  ? AppColors.surfaceDark
                  : AppColors.surfaceLight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark ? AppColors.borderDark : Colors.grey.shade100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
