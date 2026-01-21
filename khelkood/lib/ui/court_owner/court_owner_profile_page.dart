import 'package:flutter/material.dart';
import '../../design/app_colors.dart';
import '../../design/app_dimensions.dart';
import 'widgets/court_owner_card.dart';
import 'package:common/providers/auth_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourtOwnerProfilePage extends ConsumerWidget {
  const CourtOwnerProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentUserAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.backgroundDark
          : AppColors.backgroundLight,
      body: SafeArea(
        child: currentUserAsync.when(
          data: (user) {
            if (user == null) {
              return const Center(child: Text("User not found"));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingLG),
              child: Column(
                children: [
                  _buildProfileHeader(isDark, user),
                  const SizedBox(height: AppDimensions.paddingXXL),
                  _buildInfoSection('Personal Information', [
                    _buildInfoItem(
                      Icons.person_outline,
                      'Full Name',
                      user.displayName ?? 'N/A',
                      isDark,
                    ),
                    _buildInfoItem(
                      Icons.phone_outlined,
                      'Phone Number',
                      user.phoneNumber ?? 'N/A',
                      isDark,
                    ),
                    _buildInfoItem(
                      Icons.email_outlined,
                      'Email Address',
                      user.email ?? 'N/A',
                      isDark,
                    ),
                  ], isDark),
                  const SizedBox(height: AppDimensions.paddingLG),
                  _buildInfoSection('Settings & Preferences', [
                    _buildMenuItem(
                      Icons.notifications_active_outlined,
                      'Notification Settings',
                      isDark,
                    ),
                    _buildMenuItem(
                      Icons.lock_outline,
                      'Change Password',
                      isDark,
                    ),
                    _buildMenuItem(
                      Icons.help_outline,
                      'Get Help & Support',
                      isDark,
                    ),
                    _buildMenuItem(
                      Icons.description_outlined,
                      'Terms & Policies',
                      isDark,
                    ),
                  ], isDark),
                  const SizedBox(height: AppDimensions.paddingXXL),
                  _buildLogoutButton(isDark, ref),
                  const SizedBox(height: AppDimensions.paddingXXL),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark, var user) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                  width: 4,
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    (user.photoUrl != null && user.photoUrl!.startsWith('http'))
                        ? user.photoUrl!
                        : 'https://lh3.googleusercontent.com/aida-public/AB6AXuBLG7AWxmKyggNZ3CDrpKO6m6ZDKwLDO0WSulz4T19_0iuZiGIJRlIXo8ujF-1SwHboJzg2_UkA9z1r6LtMad1mRdNoHYfvbRkf5ZWOpvYHBphU5EnYEVuDMKfa6Khuutb1xnR1bWBzuvoTD_az7CJhgJl8CnNfiytfQ9793WLjT9Oizx1xtrkyERj6O7dA8e3sbcjrQhbOLfXXh6Lj40LHLgfUvAhpDxe1gFaUsYjgfSGszUm8-yX9fTMVTexms3YlJAPLn0jpw10',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: const Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          user.displayName ?? 'No Name',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const Text(
          'Owner', // Role is hardcoded as Owner for this page, or could be user.role
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, List<Widget> items, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        CourtOwnerCard(
          padding: EdgeInsets.zero,
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    IconData icon,
    String label,
    String value,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingLG),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isDark ? Colors.white70 : Colors.black54,
              size: 20,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingLG),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, bool isDark) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLG,
        vertical: 4,
      ),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white70 : Colors.black54,
          size: 20,
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton(bool isDark, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        final authService = ref.read(authServiceProvider);
        await authService.signOut();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.withOpacity(0.1),
        foregroundColor: Colors.red,
        elevation: 0,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
          side: BorderSide(color: Colors.red.withOpacity(0.2)),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout_outlined, size: 20),
          SizedBox(width: 8),
          Text(
            'Log Out',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
