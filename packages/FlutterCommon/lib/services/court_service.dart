// This source code was written for the khelkood monorepo.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/court_model.dart';
import '../providers/firebase_provider.dart';

class CourtService {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  CourtService(this._firestore, this._functions);

  /// Collection reference for courts
  CollectionReference<CourtModel> get _courtsRef =>
      _firestore.collection('courts').withConverter<CourtModel>(
            fromFirestore: CourtModel.fromFirestore,
            toFirestore: (court, _) => court.toFirestore(),
          );

  /// Add a new court via Cloud Function
  Future<void> addCourt(CourtModel court) async {
    final HttpsCallable callable = _functions.httpsCallable('addCourt');
    await callable.call(court.toMap());
  }

  /// Update an existing court via Cloud Function
  Future<void> updateCourt(CourtModel court) async {
    final HttpsCallable callable = _functions.httpsCallable('updateCourt');
    await callable.call(court.toMap());
  }

  /// Get courts with optional filters via Cloud Function
  Future<List<CourtModel>> getCourts(
      {String? ownerId, String? sportType}) async {
    final HttpsCallable callable = _functions.httpsCallable('getCourts');
    final result = await callable.call({
      if (ownerId != null) 'ownerId': ownerId,
      if (sportType != null) 'sportType': sportType,
    });

    final data = result.data as List<dynamic>?;
    if (data == null) return [];

    return data
        .map((e) => CourtModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  /// Stream courts for a specific owner
  Stream<List<CourtModel>> watchOwnerCourts(String ownerId) {
    return _courtsRef
        .where('ownerId', isEqualTo: ownerId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Get a single court by ID
  Future<CourtModel?> getCourtById(String courtId) async {
    final doc = await _courtsRef.doc(courtId).get();
    return doc.data();
  }
}

/// Provider for CourtService
final courtServiceProvider = Provider<CourtService>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final functions = ref.watch(firebaseFunctionsProvider);
  return CourtService(firestore, functions);
});
