// This source code was written for the khelkood monorepo.

import 'package:common/models/court_model.dart';
import 'package:common/services/court_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier for managing the selected sport category filter on explore page
class SelectedSportCategoryNotifier extends Notifier<String> {
  @override
  String build() => 'All';

  void selectCategory(String category) {
    state = category;
  }
}

/// Provider for the selected sport category filter on explore page
final selectedSportCategoryProvider =
    NotifierProvider<SelectedSportCategoryNotifier, String>(
      SelectedSportCategoryNotifier.new,
    );

/// Provider for approved courts list, filtered by selected sport category
///
/// Streams real-time updates from Firestore for courts with
/// `isVerified: 'approved'` status.
final exploreCourtsProvider = StreamProvider.autoDispose<List<CourtModel>>((
  ref,
) {
  final courtService = ref.watch(courtServiceProvider);
  final selectedSport = ref.watch(selectedSportCategoryProvider);
  final sportFilter = selectedSport == 'All' ? null : selectedSport;
  return courtService.watchApprovedCourts(sportType: sportFilter);
});

/// Provider for featured courts (top-rated approved courts)
///
/// Takes the top 5 courts sorted by rating in descending order.
final featuredCourtsProvider = Provider.autoDispose<List<CourtModel>>((ref) {
  final courtsAsync = ref.watch(exploreCourtsProvider);
  return courtsAsync.when(
    data: (courts) {
      final sorted = [...courts]..sort((a, b) => b.rating.compareTo(a.rating));
      return sorted.take(5).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});
