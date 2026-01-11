import 'package:flutter/material.dart';
import '../../../design/app_colors.dart';
import '../../../design/app_dimensions.dart';

class CourtOwnerBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CourtOwnerBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(
            context,
            index: 0,
            icon: Icons.dashboard_outlined,
            label: 'Home',
            isActive: currentIndex == 0,
          ),
          _buildNavItem(
            context,
            index: 1,
            icon: Icons.calendar_month_outlined,
            label: 'Bookings',
            isActive: currentIndex == 1,
          ),
          _buildFab(context),
          _buildNavItem(
            context,
            index: 2,
            icon: Icons.stadium_outlined,
            label: 'Courts',
            isActive: currentIndex == 2,
          ),
          _buildNavItem(
            context,
            index: 3,
            icon: Icons.person_outline,
            label: 'Profile',
            isActive: currentIndex == 3,
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
      onTap: () => onTap(index),
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

  Widget _buildFab(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -20),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 28),
      ),
    );
  }
}
