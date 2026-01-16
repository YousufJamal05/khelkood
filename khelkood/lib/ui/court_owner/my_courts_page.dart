import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:common/common.dart';
import '../../design/app_colors.dart';
import '../../design/app_dimensions.dart';
import '../../providers/court_provider.dart';
import '../../routing/app_router.dart';
import 'widgets/court_owner_card.dart';

class MyCourtsPage extends ConsumerWidget {
  const MyCourtsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final courtsAsync = ref.watch(ownerCourtsProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, isDark),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () =>
                    ref.read(ownerCourtsProvider.notifier).refresh(),
                child: courtsAsync.when(
                  data: (courts) {
                    if (courts.isEmpty) {
                      return ListView(
                        children: [
                          const SizedBox(height: 100),
                          Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.sports_soccer,
                                  size: 64,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No courts added yet',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(AppDimensions.paddingLG),
                      itemCount: courts.length + 1, // +1 for the FAB space
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppDimensions.paddingLG),
                      itemBuilder: (context, index) {
                        if (index == courts.length) {
                          return const SizedBox(height: 80); // Space for FAB
                        }
                        final court = courts[index];
                        return _buildCourtCard(
                          context,
                          ref,
                          court: court,
                          isDark: isDark,
                        );
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error: $err')),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRouter.ownerAddCourt),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add New Court',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
        ],
      ),
    );
  }

  Widget _buildCourtCard(
    BuildContext context,
    WidgetRef ref, {
    required CourtModel court,
    required bool isDark,
  }) {
    final status = court.isVerified.toLowerCase();
    Color statusColor;
    String statusText;

    switch (status) {
      case 'approved':
        statusColor = AppColors.primary;
        statusText = 'ACTIVE';
        break;
      case 'rejected':
        statusColor = Colors.red;
        statusText = 'REJECTED';
        break;
      case 'pending':
      default:
        statusColor = Colors.orange;
        statusText = 'PENDING';
        break;
    }

    final isActive = status == 'approved' || status == 'pending';

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
                  child: Icon(
                    _getSportIcon(court.sportTypes.first),
                    color: AppColors.primary,
                    size: 32,
                  ),
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
                              court.name,
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
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              statusText,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${court.sportTypes.map((s) => s[0].toUpperCase() + s.substring(1)).join(' • ')} • ${court.area}',
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
                            Icons.payments_outlined,
                            'PKR ${court.pricing['base']}/hr',
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
                _buildActionButton(
                  Icons.edit,
                  'Edit',
                  isDark,
                  onTap: () {
                    context.push(AppRouter.ownerAddCourt, extra: court);
                  },
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  Icons.calendar_month,
                  'Schedule',
                  isDark,
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  isActive ? Icons.power_settings_new : Icons.play_arrow,
                  isActive ? 'Deactivate' : 'Activate',
                  isDark,
                  isDestructive: isActive,
                  isPositive: !isActive,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSportIcon(String sportType) {
    switch (sportType.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer_outlined;
      case 'cricket':
        return Icons.sports_cricket_outlined;
      case 'padel':
      case 'tennis':
        return Icons.sports_tennis_outlined;
      case 'badminton':
        return Icons.sports_tennis_outlined;
      default:
        return Icons.sports_outlined;
    }
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
    required VoidCallback onTap,
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
        onTap: onTap,
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
