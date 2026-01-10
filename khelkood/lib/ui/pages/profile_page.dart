import 'package:common/providers/auth_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../design/app_colors.dart';
import '../widgets/khelkhood_button.dart';
import '../views/bottom_nav_view.dart';
import 'package:go_router/go_router.dart';
import '../../routing/app_router.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUserAsync = ref.watch(currentUserProvider);
    final user = currentUserAsync.value;

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
                        image:
                            user?.photoUrl != null && user!.photoUrl!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(user.photoUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: user?.photoUrl == null || user!.photoUrl!.isEmpty
                          ? Icon(
                              Icons.person,
                              size: 60,
                              color: AppColors.primary,
                            )
                          : null,
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
                Text(
                  user?.displayName ?? "Player",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  user?.phoneNumber ?? "No Phone Number",
                  style: const TextStyle(
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
              onPressed: () async {
                final authService = ref.read(authServiceProvider);
                await authService.signOut();
              },
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
