import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supported user roles in the application.
enum UserRole { player, owner }

/// A notifier that manages the temporarily selected user role.
class UserRoleNotifier extends Notifier<UserRole> {
  static const _roleKey = 'selected_user_role';

  @override
  UserRole build() {
    _loadRole();
    return UserRole.player;
  }

  Future<void> _loadRole() async {
    final prefs = await SharedPreferences.getInstance();
    final roleString = prefs.getString(_roleKey);
    if (roleString != null) {
      if (roleString == 'owner') {
        state = UserRole.owner;
      } else {
        state = UserRole.player;
      }
    }
  }

  Future<void> setRole(UserRole role) async {
    state = role;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _roleKey,
      role == UserRole.owner ? 'owner' : 'player',
    );
  }
}

/// A provider that stores the temporarily selected user role during the onboarding/auth flow.
final selectedRoleProvider = NotifierProvider<UserRoleNotifier, UserRole>(
  UserRoleNotifier.new,
);
