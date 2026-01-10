import 'package:common/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../design/app_colors.dart';
import '../widgets/khelkhood_chip.dart';
import '../widgets/court_card_featured.dart';
import '../widgets/court_card_list.dart';
import '../views/bottom_nav_view.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends ConsumerState<ExplorePage> {
  int _selectedCategoryIndex = 0;
  final List<Map<String, String>> _categories = [
    {'label': 'All', 'emoji': ''},
    {'label': 'Cricket', 'emoji': '🏏'},
    {'label': 'Futsal', 'emoji': '⚽'},
    {'label': 'Padel', 'emoji': '🎾'},
    {'label': 'Badminton', 'emoji': '🏸'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final currentUserAsync = ref.watch(currentUserProvider);
    final user = currentUserAsync.value;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary, width: 2),
                        image:
                            user?.photoUrl != null && user!.photoUrl!.isNotEmpty
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
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondaryLight,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            user?.displayName ?? "Player",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark
                                ? AppColors.borderDark
                                : AppColors.borderLight,
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "Karachi",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Stack(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceDark
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? AppColors.borderDark
                                  : AppColors.borderLight,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.notifications_outlined,
                              size: 22,
                            ),
                            onPressed: () =>
                                context.push(AppRouter.notifications),
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
                                color: isDark
                                    ? AppColors.surfaceDark
                                    : Colors.white,
                                width: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.surfaceDark : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark
                          ? AppColors.borderDark
                          : AppColors.borderLight,
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
                            hintStyle: TextStyle(
                              color: isDark
                                  ? AppColors.textTertiaryDark
                                  : AppColors.textTertiaryLight,
                              fontSize: 14,
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
                        color: isDark
                            ? AppColors.borderDark
                            : AppColors.borderLight,
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.tune, size: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Categories
              SingleChildScrollView(
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
                        isSelected: _selectedCategoryIndex == index,
                        onTap: () =>
                            setState(() => _selectedCategoryIndex = index),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Featured Courts
              HeaderSection(title: "Featured Courts", onSeeAll: () {}),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    CourtCardFeatured(
                      title: "Smash Arena",
                      location: "DHA Phase 6",
                      price: "PKR 3,000/hr",
                      rating: "4.8",
                      imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuAdqxXpj-kNDa6cFN2A44b0Iq5BFv8I28_34LdJ0OHE04XwpMU878f__2bYr6QpHy7csLwaPvPNMZQeiXeLxBhQoh5raKPutoeiHmh3s1vC13YkgbkJ6FgaSR-c8ncN_rO_hcIRD5vugkLaoDl6TkoG_OZ9eXYa74gOXweKsHe4yY7jc7I6CZ6uGZsBliVYhX-L4oSbjlLBpnVH8wEDBMqQcCc5Gmc4qzF5Aso8E1XyfLoCaFumNAxeTOEC_EEC31qnBybA4XCVdqU",
                      onTap: () => context.push(AppRouter.details),
                    ),
                    CourtCardFeatured(
                      title: "Ace Padel Club",
                      location: "Clifton Block 4",
                      price: "PKR 4,500/hr",
                      rating: "4.5",
                      imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuD7bbjgoFbTlSvuFEaxt6zS41lKkdpJKXKnUCIWVQmIqqfex2alyJvB_piKdf_nrmjbawluqUtfNFUQx20RgrGFAAc5XlPOiOgI8XfAPkH4j71Ks7CTL8G9OHibxJDwPxJi2DKePe9ktxZL01-t5H3b56rSQzXRisCtbnCVUwo1TpwjzVYlVcCWn5A25Koe2S8-brlwIR1nrwXR6oPHoyOXWpfB5K58MhOjwgwjfpTYJ0e7SVBZi7gflH9_-0n7fx1I3u7FJy6qV3E",
                      onTap: () => context.push(AppRouter.details),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Courts Near You
              HeaderSection(title: "Courts Near You", onSeeAll: () {}),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CourtCardList(
                      title: "Powerplay Nets",
                      location: "Gulshan-e-Iqbal",
                      distance: "1.2 km",
                      price: "PKR 1,500/hr",
                      rating: "4.5",
                      imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuAVkiviyEEfa_D-odhbEJR1taRU0ZNR2cygmSQE5YuytOiGKAOs97pACkTnxkR6sbwiBSqMTqCJBZzEyfR7Sa7uVaiPQBDrAeF-VDjMuE4awZGpeU7KeP45Gsz_PsMzuSgwCmgq9kMPjCTEP3uOGBWuuxrYpiEMoneLVXc7xKrWUrRd_tyZirfCMWXiay1QUpiEjprsX4e4K0OKcS2C09ga4mSa-2s62NRrwxrOPshDy6yaMQxL9eacUg6iBmVTeSXIDthNrKx9E9c",
                      onTap: () => context.push(AppRouter.details),
                    ),
                    CourtCardList(
                      title: "North Walk Futsal",
                      location: "North Nazimabad",
                      distance: "3.5 km",
                      price: "PKR 2,000/hr",
                      rating: "4.2",
                      imageUrl:
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuCoNTO5OMtSypIwzOq1_TpgCN9sU6x1Gyd8dcpITOY0Fxlrl0eNbc79c3zvj8uZOPke1JyjKIXf1udktIonKXMRi2nUgLfgpnLjINDUFoim8udSZE8FGEO5ppLJJnzgmAmbTa0v6_s2zCbzdKfwEzqP1f2pKaSmAqku_WCSA9d4MtyJ9cXf3oZsdLYYwUTLcVZsGnyqdWQBFsNrdcE6EY19NS98TxCnlezfIbmQj2Cjl5jH5zqgPiuCFoPQH1MOK187PCT65VzCkKE",
                      onTap: () => context.push(AppRouter.details),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80), // For bottom nav
            ],
          ),
        ),
      ),
      bottomNavigationBar: KhelKhoodBottomNav(
        selectedIndex: 0,
        onItemSelected: (index) {
          if (index == 1) {
            context.push(AppRouter.bookings);
          } else if (index == 2) {
            context.push(AppRouter.map);
          } else if (index == 3) {
            context.push(AppRouter.profile);
          }
        },
      ),
    );
  }
}

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
