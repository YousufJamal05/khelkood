import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import '../widgets/khelkhood_button.dart';
import '../views/bottom_nav_view.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Profile Header
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://lh3.googleusercontent.com/aida-public/AB6AXuC-XOEIxzYdNwfczeZArxg5Oeh0RXt6GLHhw2Upi8ykU9cZnAPLR2BxIDmeQ2gy0wWKvxNreAW1PGNVUJom6XxF1ItvJFEvHsSsp4b7wDkhnlu0MhXojH-0P2npKbXQUapdlowZTi9LepzkcWrJyioSyoC84-_BdbrQus1zuizo-RhrKbkA2T1VFoV-8soKgMOjIvqqPE3pnCIBzOxoZQYbYJqu1PJtw51nnDqBjaQntinP63uBeVEmjXEbfFarZ_rxE9oV2J6D-5c",
                          ),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark
                              ? AppColors.backgroundDark
                              : Colors.white,
                          width: 3,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  "Saad Ahmed",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const Text(
                  "+92 300 1234567",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Settings Groups
            _SettingsGroup(
              isDark: isDark,
              items: [
                _SettingsItem(
                  icon: Icons.calendar_month,
                  label: "My Bookings",
                  onTap: () => context.push(AppRouter.bookings),
                ),
                _SettingsItem(
                  icon: Icons.favorite,
                  label: "Favorite Courts",
                  onTap: () => context.push(AppRouter.favorites),
                ),
                const _SettingsItem(
                  icon: Icons.payment,
                  label: "Payment Methods",
                  subtitle: "Coming soon",
                ),
              ],
            ),
            const SizedBox(height: 20),
            _SettingsGroup(
              isDark: isDark,
              items: const [
                _SettingsItem(
                  icon: Icons.notifications_none,
                  label: "Notification Settings",
                ),
                _SettingsItem(
                  icon: Icons.help_outline,
                  label: "Help & Support",
                ),
                _SettingsItem(
                  icon: Icons.shield_outlined,
                  label: "Terms & Privacy",
                ),
                _SettingsItem(
                  icon: Icons.info_outline,
                  label: "About KhelKhood",
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Logout
            KhelKhoodButton(
              text: "Logout",
              isSecondary: true,
              onPressed: () {},
            ),
            const SizedBox(height: 24),
            Text(
              "App Version 1.0.0",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: KhelKhoodBottomNav(
        selectedIndex: 3,
        onItemSelected: (index) {
          if (index == 0) context.go(AppRouter.explore);
          if (index == 1) context.go(AppRouter.bookings);
          if (index == 2) context.push(AppRouter.map);
        },
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<_SettingsItem> items;
  final bool isDark;
  const _SettingsGroup({required this.items, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              item,
              if (index < items.length - 1)
                Divider(
                  height: 1,
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback? onTap;

  const _SettingsItem({
    required this.icon,
    required this.label,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(color: AppColors.primary, fontSize: 10),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
    );
  }
}
