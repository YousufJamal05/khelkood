enum CourtStatus {
  pending,
  approved,
  rejected;

  String get name => toString().split('.').last;

  static CourtStatus fromString(String value) {
    return CourtStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => CourtStatus.pending,
    );
  }
}
