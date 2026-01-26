// This source code was written for the khelkood monorepo.

import 'package:common/models/court_model.dart';
import 'package:common/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../design/app_colors.dart';
import '../../providers/explore_courts_provider.dart';
import '../../routing/app_router.dart';
import '../views/bottom_nav_view.dart';
import '../widgets/court_card_featured.dart';
import '../widgets/court_card_list.dart';
import '../widgets/khelkhood_chip.dart';

/// Categories for filtering courts by sport type
const List<Map<String, String>> _categories = [
  {'label': 'All', 'emoji': ''},
  {'label': 'Cricket', 'emoji': '🏏'},
  {'label': 'Football', 'emoji': '⚽'},
  {'label': 'Padel', 'emoji': '🎾'},
  {'label': 'Badminton', 'emoji': '🏸'},
];

/// Explore page displaying approved courts for players to browse and book
class ExplorePage extends ConsumerWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUserAsync = ref.watch(currentUserProvider);
    final user = currentUserAsync.value;
    final selectedCategory = ref.watch(selectedSportCategoryProvider);
    final courtsAsync = ref.watch(exploreCourtsProvider);
    final featuredCourts = ref.watch(featuredCourtsProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, isDark, user),
              _buildSearchBar(context, isDark),
              const SizedBox(height: 16),
              _buildCategories(context, ref, selectedCategory),
              const SizedBox(height: 24),
              _buildFeaturedCourtsSection(context, featuredCourts),
              const SizedBox(height: 24),
              _buildNearYouSection(context, courtsAsync),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: KhelKhoodBottomNav(
        selectedIndex: 0,
        onItemSelected: (index) => _handleNavigation(context, index),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, dynamic user) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
              image: user?.photoUrl != null && user!.photoUrl!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(user.photoUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: user?.photoUrl == null || user!.photoUrl!.isEmpty
                ? const Icon(Icons.person, color: AppColors.primary)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Let's Play,",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  user?.displayName ?? "Player",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "Karachi",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          _buildNotificationButton(context, isDark),
        ],
      ),
    );
  }

  Widget _buildNotificationButton(BuildContext context, bool isDark) {
    return Stack(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined, size: 22),
            onPressed: () => context.push(AppRouter.notifications),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                readOnly: true,
                onTap: () => context.push(AppRouter.search),
                decoration: InputDecoration(
                  hintText: "Search courts, sports, or area",
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.textTertiaryDark
                        : AppColors.textTertiaryLight,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Container(
              height: 24,
              width: 1,
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
            const SizedBox(width: 12),
            const Icon(Icons.tune, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(
    BuildContext context,
    WidgetRef ref,
    String selectedCategory,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          _categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: KhelKhoodChip(
              label: _categories[index]['label']!,
              emoji: _categories[index]['emoji']!.isEmpty
                  ? null
                  : _categories[index]['emoji'],
              isSelected: selectedCategory == _categories[index]['label'],
              onTap: () => ref
                  .read(selectedSportCategoryProvider.notifier)
                  .selectCategory(_categories[index]['label']!),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCourtsSection(
    BuildContext context,
    List<CourtModel> featuredCourts,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderSection(title: "Featured Courts", onSeeAll: () {}),
        const SizedBox(height: 16),
        if (featuredCourts.isEmpty)
          _buildEmptyState("No featured courts available")
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: featuredCourts
                  .map(
                    (court) => CourtCardFeatured.fromModel(
                      court: court,
                      onTap: () => context.push(AppRouter.details),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildNearYouSection(
    BuildContext context,
    AsyncValue<List<CourtModel>> courtsAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderSection(title: "Courts Near You", onSeeAll: () {}),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: courtsAsync.when(
            data: (courts) {
              if (courts.isEmpty) {
                return _buildEmptyState("No courts found in your area");
              }
              return Column(
                children: courts
                    .map(
                      (court) => CourtCardList.fromModel(
                        court: court,
                        onTap: () => context.push(AppRouter.details),
                      ),
                    )
                    .toList(),
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (error, _) => _buildErrorState(error.toString()),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(color: AppColors.textTertiaryLight),
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            Text(
              'Failed to load courts',
              style: TextStyle(color: Colors.red.shade700),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    if (index == 1) {
      context.push(AppRouter.bookings);
    } else if (index == 2) {
      context.push(AppRouter.map);
    } else if (index == 3) {
      context.push(AppRouter.profile);
    }
  }
}

/// Header section with title and "See All" button
class HeaderSection extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const HeaderSection({super.key, required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: const Text(
              "See All",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
