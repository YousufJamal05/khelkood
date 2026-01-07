import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import '../views/bottom_nav_view.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Simulated Map Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: NetworkImage(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuAr7W6p72vWv-9W3G6m4Uv0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6G2N1B4p7v0vX_P4O6W",
                ),
                fit: BoxFit.cover,
                opacity: 0.8,
              ),
              color: isDark ? AppColors.surfaceDark : Colors.grey[200],
            ),
            child: Center(
              child: Icon(
                Icons.map_rounded,
                size: 80,
                color: isDark ? Colors.white24 : Colors.black12,
              ),
            ),
          ),

          // Header Search Bar
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.go(AppRouter.explore),
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search in this area",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(Icons.tune, color: AppColors.primary),
                ],
              ),
            ),
          ),

          // Floating Action Buttons
          Positioned(
            right: 20,
            bottom: 120,
            child: Column(
              children: [
                _MapFab(icon: Icons.my_location, isDark: isDark),
                const SizedBox(height: 12),
                _MapFab(icon: Icons.add, isDark: isDark),
                const SizedBox(height: 12),
                _MapFab(icon: Icons.remove, isDark: isDark),
              ],
            ),
          ),

          // Horizontal Venue List at Bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 100,
            child: SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: const DecorationImage(
                              image: NetworkImage(
                                "https://lh3.googleusercontent.com/aida-public/AB6AXuAdqxXpj-kNDa6cFN2A44b0Iq5BFv8I28_34LdJ0OHE04XwpMU878f__2bYr6QpHy7csLwaPvPNMZQeiXeLxBhQoh5raKPutoeiHmh3s1vC13YkgbkJ6FgaSR-c8ncN_rO_hcIRD5vugkLaoDl6TkoG_OZ9eXYa74gOXweKsHe4yY7jc7I6CZ6uGZsBliVYhX-L4oSbjlLBpnVH8wEDBMqQcCc5Gmc4qzF5Aso8E1XyfLoCaFumNAxeTOEC_EEC31qnBybA4XCVdqU",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Smash Arena",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Text(
                                "DHA Phase 6 • 1.2km",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                  const Text(
                                    " 4.5",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Rs. 2500/hr",
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: KhelKhoodBottomNav(
        selectedIndex: 2,
        onItemSelected: (index) {
          if (index == 0) context.go(AppRouter.explore);
          if (index == 1) context.go(AppRouter.bookings);
          if (index == 3) context.go(AppRouter.profile);
        },
      ),
    );
  }
}

class _MapFab extends StatelessWidget {
  final IconData icon;
  final bool isDark;
  const _MapFab({required this.icon, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.primary, size: 20),
    );
  }
}
