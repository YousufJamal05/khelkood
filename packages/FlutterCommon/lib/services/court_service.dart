// This source code was written for the khelkood monorepo.

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/court_model.dart';
import '../providers/firebase_provider.dart';

class CourtService {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  final FirebaseStorage _storage;

  CourtService(this._firestore, this._functions, this._storage);

  /// Collection reference for courts
  CollectionReference<CourtModel> get _courtsRef =>
      _firestore.collection('courts').withConverter<CourtModel>(
            fromFirestore: CourtModel.fromFirestore,
            toFirestore: (court, _) => court.toFirestore(),
          );

  /// Generate a new unique document ID for a court locally
  String generateCourtId() {
    return _firestore.collection('courts').doc().id;
  }

  /// Upload court image to Firebase Storage
  Future<String> uploadCourtImage({
    required String courtId,
    required String fileName,
    required List<int> imageBytes,
    required String contentType,
  }) async {
    final ref = _storage.ref().child('courts').child(courtId).child(fileName);
    final metadata = SettableMetadata(contentType: contentType);
    final uploadTask = ref.putData(Uint8List.fromList(imageBytes), metadata);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

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
        .map((e) => CourtModel.fromMap(Map<String, dynamic>.from(e as Map)))
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

  /// Watch availability for a specific court and date
  Stream<Map<String, dynamic>> watchAvailability(String courtId, String date) {
    return _firestore
        .collection('courts')
        .doc(courtId)
        .collection('availability')
        .doc(date)
        .snapshots()
        .map((doc) => doc.data()?['slots'] as Map<String, dynamic>? ?? {});
  }

  /// Block specific slots for a court and date via Cloud Function
  Future<void> blockSlots({
    required String courtId,
    required String date,
    required List<String> slots,
    required String reason,
    String? additionalNotes,
  }) async {
    final HttpsCallable callable = _functions.httpsCallable('blockSlots');
    await callable.call({
      'courtId': courtId,
      'date': date,
      'slots': slots,
      'reason': reason,
      if (additionalNotes != null) 'additionalNotes': additionalNotes,
    });
  }
}

/// Provider for CourtService
final courtServiceProvider = Provider<CourtService>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final functions = ref.watch(firebaseFunctionsProvider);
  final storage = ref.watch(firebaseStorageProvider);
  return CourtService(firestore, functions, storage);
});
