import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import '../widgets/khelkhood_chip.dart';
import '../widgets/court_card_list.dart';
import '../views/bottom_nav_view.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _selectedCategoryIndex = 0;
  final List<Map<String, String>> _categories = [
    {'label': 'All', 'emoji': ''},
    {'label': 'Cricket', 'emoji': '🏏'},
    {'label': 'Futsal', 'emoji': '⚽'},
    {'label': 'Padel', 'emoji': '🎾'},
    {'label': 'Swimming', 'emoji': '🏊'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight,
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              const Icon(Icons.search, color: AppColors.primary, size: 20),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Arenas, areas, or sports...",
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.tune, size: 20),
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: List.generate(
                    _categories.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    _SmallFilterChip(
                      label: "Sort: Recommended",
                      icon: Icons.keyboard_arrow_down,
                      isDark: isDark,
                    ),
                    _SmallFilterChip(
                      label: "Price Range",
                      icon: Icons.keyboard_arrow_down,
                      isDark: isDark,
                    ),
                    _SmallFilterChip(
                      label: "Area",
                      icon: Icons.keyboard_arrow_down,
                      isDark: isDark,
                    ),
                    _SmallFilterChip(
                      label: "Date",
                      icon: Icons.calendar_today,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    "24 Venues found",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => context.push(AppRouter.map),
                  icon: const Icon(Icons.map, size: 18),
                  label: const Text("View Map"),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                CourtCardList(
                  title: "Smash Arena DHA",
                  location: "Phase 6, 2.5km away",
                  distance: "2.5km",
                  price: "Rs. 2500/hr",
                  rating: "4.8",
                  imageUrl:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuCWIwjoIRuJoyuAY_W9YhBxQMDS9kt933AuOES5kSc5qcoNWLcFC7Id2SC3nvdLHQ3yopbQ_U_zZrWl2Be0yQ5hsdqV3QQv6Cz2WSVOJva0qXQHQOiVElS5myahcQEJ0n9T6QkpfEuzodeQXMAex4rsSxgYWEhjxJ4uhfAqyYW4fTHb0T7ECsqdlNCyCPXf0f0A6QIn8HhloR-7aKGVnc3qUMi9wQKiihfFr16qC7GZJxAY_kPD_oMQd2zvkL4zXMqncJvXpaAmi7Q",
                  onTap: () => context.push(AppRouter.details),
                ),
                const SizedBox(height: 16),
                CourtCardList(
                  title: "Powerplay North",
                  location: "North Nazimabad, 8km away",
                  distance: "8km",
                  price: "Rs. 3000/hr",
                  rating: "4.9",
                  imageUrl:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuAmZPyhaYEALk3pkZcegnCQKw0IYJSJs52ClO0sKoDhImitEsvLIwuncQ-Dava5gCn2jgP4cUWiBLNNezWuDfRw-yNY9zVo-JHRj17zs8w8TZRPyz5Z3zK-PdS94Ceg-xy-PgWzYE99YE1efkjFqigFrabcIMXHjwD3zCJIEMVgccIWaWi-1Q1QTKay0muidDApVJLjJEgutl6NVrfBAAR-pz6KqMkRCgtDHWUtmqNUb7c-Jz8g3tKlr-P8k3Jgjcz862qdZ918bYg",
                  onTap: () => context.push(AppRouter.details),
                ),
                const SizedBox(height: 16),
                CourtCardList(
                  title: "Ace Padel Club",
                  location: "Clifton Block 4, 3.2km away",
                  distance: "3.2km",
                  price: "Rs. 4500/hr",
                  rating: "5.0",
                  imageUrl:
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuAiIxWdKsFrX17l2uXhXqf68yM4pade_ySOX1jlCsm0xUq3o4C8XwJmIibhupgLbQF8vQL6D8pjVGWHyMx4Ig7MHl-tWPBklwtrA8_97UwvBVo7yrgK98nj7kPJpqFsWNO7S-3B1zVVbu80SumAgQcDOK8ewCv0LdjOo-0DTpM9yworStn63-K2Z0owkWVqNREFdnPJllZoTW8I7NXJRlvNRZQuUKfemDWBFyS93pz_LrA0msiJnG-KgyhLo_XAbVAn61BKVNw3Frw",
                  onTap: () => context.push(AppRouter.details),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: KhelKhoodBottomNav(
        selectedIndex: 0,
        onItemSelected: (index) {
          if (index == 0) context.go(AppRouter.explore);
          if (index == 1) context.go(AppRouter.bookings);
          if (index == 2) context.push(AppRouter.map);
          if (index == 3) context.go(AppRouter.profile);
        },
      ),
    );
  }
}

class _SmallFilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isDark;
  const _SmallFilterChip({
    required this.label,
    required this.icon,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Icon(icon, size: 14, color: Colors.grey),
        ],
      ),
    );
  }
}
