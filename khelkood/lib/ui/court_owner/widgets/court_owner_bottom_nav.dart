import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../design/app_colors.dart';
import '../../../design/app_dimensions.dart';

class CourtOwnerBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CourtOwnerBottomNav({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.white
            : AppColors.surfaceDark,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).brightness == Brightness.light
                ? AppColors.backgroundLight
                : AppColors.backgroundDark,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        top: AppDimensions.paddingSM,
        bottom: MediaQuery.of(context).padding.bottom + AppDimensions.paddingSM,
        left: AppDimensions.paddingLG,
        right: AppDimensions.paddingLG,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            index: 0,
            icon: Icons.dashboard_outlined,
            label: 'Home',
            isActive: navigationShell.currentIndex == 0,
          ),
          _buildNavItem(
            context,
            index: 1,
            icon: Icons.calendar_month_outlined,
            label: 'Bookings',
            isActive: navigationShell.currentIndex == 1,
          ),
          _buildNavItem(
            context,
            index: 2,
            icon: Icons.stadium_outlined,
            label: 'Courts',
            isActive: navigationShell.currentIndex == 2,
          ),
          _buildNavItem(
            context,
            index: 3,
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: navigationShell.currentIndex == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    final color = isActive ? AppColors.primary : Colors.grey;
    return GestureDetector(
      onTap: () => navigationShell.goBranch(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
