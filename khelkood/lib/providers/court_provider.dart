import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/common.dart';

/// Provider for the list of courts owned by the currently logged-in owner
final ownerCourtsProvider =
    AsyncNotifierProvider<OwnerCourtsNotifier, List<CourtModel>>(
      OwnerCourtsNotifier.new,
    );

class OwnerCourtsNotifier extends AsyncNotifier<List<CourtModel>> {
  StreamSubscription<List<CourtModel>>? _subscription;

  @override
  FutureOr<List<CourtModel>> build() async {
    final userResult = ref.watch(authStateProvider);
    final user = userResult.value;
    if (user == null) return [];

    final courtService = ref.watch(courtServiceProvider);

    // Initial fetch
    final initialCourts = await courtService.getCourts(ownerId: user.uid);

    // Set up real-time listener
    _subscription?.cancel();
    _subscription = courtService.watchOwnerCourts(user.uid).listen((courts) {
      state = AsyncData(courts);
    });

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return initialCourts;
  }

  /// Refresh the court list manually
  Future<void> refresh() async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;

    state = const AsyncLoading();
    try {
      final courts = await ref
          .read(courtServiceProvider)
          .getCourts(ownerId: user.uid);
      state = AsyncData(courts);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Add a new court and refresh the list
  Future<void> addCourt(CourtModel court) async {
    await ref.read(courtServiceProvider).addCourt(court);
    // Real-time listener will update the state
  }

  /// Update a court and refresh the list
  Future<void> updateCourt(CourtModel court) async {
    await ref.read(courtServiceProvider).updateCourt(court);
    // Real-time listener will update the state
  }
}
