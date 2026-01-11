import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Supported user roles in the application.
enum UserRole { player, owner }

/// A notifier that manages the temporarily selected user role.
class UserRoleNotifier extends Notifier<UserRole> {
  @override
  UserRole build() => UserRole.player;

  void setRole(UserRole role) => state = role;
}

/// A provider that stores the temporarily selected user role during the onboarding/auth flow.
final selectedRoleProvider = NotifierProvider<UserRoleNotifier, UserRole>(
  UserRoleNotifier.new,
);
