enum UserRole {
  player,
  owner,
  admin;

  String get name => toString().split('.').last;

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UserRole.player,
    );
  }
}

enum UserStatus {
  pending,
  active,
  suspended;

  String get name => toString().split('.').last;

  static UserStatus fromString(String value) {
    return UserStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UserStatus.active,
    );
  }
}
