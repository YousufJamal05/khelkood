import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../design/app_colors.dart';
import '../../../../design/app_dimensions.dart';

class DateScroller extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onCalendarTap;
  final bool isDark;

  const DateScroller({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onCalendarTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLG,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: onCalendarTap,
                icon: const Icon(Icons.calendar_month, size: 18),
                label: Text(DateFormat('MMMM yyyy').format(selectedDate)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLG,
            ),
            itemCount: 30, // Show next 30 days
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected = DateUtils.isSameDay(date, selectedDate);
              final dayName = DateFormat('EEE').format(date);
              final dayNum = DateFormat('d').format(date);

              return GestureDetector(
                onTap: () => onDateSelected(date),
                child: Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(36),
                    border: isSelected
                        ? Border.all(color: AppColors.primary, width: 2.5)
                        : Border.all(
                            color: isDark
                                ? AppColors.borderDark
                                : Colors.grey.shade100,
                          ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.15),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dayNum,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      if (isSelected)
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
