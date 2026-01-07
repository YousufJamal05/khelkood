import 'package:flutter/material.dart';
import '../../design/app_colors.dart';

class KhelKhoodBottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const KhelKhoodBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_filled,
            label: "Explore",
            isSelected: selectedIndex == 0,
            onTap: () => onItemSelected(0),
            isDark: isDark,
          ),
          _NavItem(
            icon: Icons.calendar_month,
            label: "Bookings",
            isSelected: selectedIndex == 1,
            onTap: () => onItemSelected(1),
            isDark: isDark,
          ),
          _NavItem(
            icon: Icons.map_outlined,
            label: "Map",
            isSelected: selectedIndex == 2,
            onTap: () => onItemSelected(2),
            isDark: isDark,
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: "Profile",
            isSelected: selectedIndex == 3,
            onTap: () => onItemSelected(3),
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? AppColors.primary
        : (isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
