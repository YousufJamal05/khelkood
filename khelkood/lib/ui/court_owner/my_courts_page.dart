import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import '../../design/app_dimensions.dart';
import 'widgets/court_owner_card.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';
import 'widgets/court_owner_bottom_nav.dart';

class MyCourtsPage extends StatelessWidget {
  const MyCourtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, isDark),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppDimensions.paddingLG),
                children: [
                  _buildCourtCard(
                    context,
                    name: 'Futsal Arena A',
                    type: 'Indoor Football • 5-a-side',
                    status: 'Active',
                    maxPlayers: '12 Max',
                    price: 'PKR 2500/hr',
                    icon: Icons.sports_soccer_outlined,
                    isDark: isDark,
                  ),
                  const SizedBox(height: AppDimensions.paddingLG),
                  _buildCourtCard(
                    context,
                    name: 'Badminton Court 1',
                    type: 'Indoor • Standard',
                    status: 'Active',
                    maxPlayers: '4 Max',
                    price: 'PKR 1200/hr',
                    icon: Icons.sports_tennis_outlined,
                    isDark: isDark,
                  ),
                  const SizedBox(height: AppDimensions.paddingLG),
                  _buildCourtCard(
                    context,
                    name: 'Tennis Court B',
                    type: 'Outdoor • Clay',
                    status: 'Inactive',
                    maxPlayers: '4 Max',
                    price: 'PKR 2000/hr',
                    icon: Icons.sports_tennis_outlined,
                    isDark: isDark,
                    isActive: false,
                  ),
                  const SizedBox(height: 80), // Space for FAB
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add New Court',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: CourtOwnerBottomNav(
        currentIndex: 2,
        onTap: (index) {
          if (index == 2) return;
          if (index == 0) context.go(AppRouter.ownerHome);
          if (index == 1) context.push(AppRouter.ownerBookings);
          if (index == 3) context.push(AppRouter.ownerProfile);
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Courts',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark
                  ? AppColors.textPrimaryDark
                  : AppColors.textPrimaryLight,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? AppColors.borderDark : Colors.grey.shade100,
              ),
            ),
            child: Row(
              children: [
                Text(
                  '3 Courts',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourtCard(
    BuildContext context, {
    required String name,
    required String type,
    required String status,
    required String maxPlayers,
    required String price,
    required IconData icon,
    required bool isDark,
    bool isActive = true,
  }) {
    return CourtOwnerCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLG),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 32),
                ),
                const SizedBox(width: AppDimensions.paddingLG),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.primary.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                color: isActive
                                    ? AppColors.primary
                                    : Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        type,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildSmallIconInfo(
                            Icons.groups_outlined,
                            maxPlayers,
                            isDark,
                          ),
                          const SizedBox(width: 16),
                          _buildSmallIconInfo(
                            Icons.payments_outlined,
                            price,
                            isDark,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: isDark ? AppColors.borderDark : Colors.grey.shade100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildActionButton(Icons.edit, 'Edit', isDark),
                const SizedBox(width: 8),
                _buildActionButton(Icons.calendar_month, 'Schedule', isDark),
                const SizedBox(width: 8),
                _buildActionButton(
                  isActive ? Icons.power_settings_new : Icons.play_arrow,
                  isActive ? 'Deactivate' : 'Activate',
                  isDark,
                  isDestructive: isActive,
                  isPositive: !isActive,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallIconInfo(IconData icon, String text, bool isDark) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: isDark
                ? AppColors.textSecondaryDark
                : AppColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    bool isDark, {
    bool isDestructive = false,
    bool isPositive = false,
  }) {
    Color color = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    Color bgColor = isDark ? Colors.grey.withOpacity(0.1) : Colors.grey.shade50;

    if (isDestructive) {
      color = Colors.red;
      bgColor = Colors.red.withOpacity(0.05);
    } else if (isPositive) {
      color = AppColors.primary;
      bgColor = AppColors.primary.withOpacity(0.05);
    }

    return Expanded(
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
