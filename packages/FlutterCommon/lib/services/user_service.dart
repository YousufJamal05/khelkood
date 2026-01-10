import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../providers/firebase_provider.dart';

class UserService {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;
  final FirebaseStorage _storage;

  UserService(this._firestore, this._functions, this._storage);

  /// Collection reference for users
  CollectionReference<UserModel> get _usersRef =>
      _firestore.collection('users').withConverter<UserModel>(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (user, _) => user.toFirestore(),
          );

  /// Get a user's profile via Cloud Function
  Future<UserModel?> getUserProfile() async {
    final HttpsCallable callable = _functions.httpsCallable('getUserProfile');
    final result = await callable.call();
    final data = result.data as Map<String, dynamic>?;
    final userData = data?['user'] as Map<String, dynamic>?;

    if (userData == null) return null;

    return UserModel.fromMap(userData);
  }

  /// Stream a user's profile by UID
  Stream<UserModel?> watchUser(String uid) {
    return _usersRef.doc(uid).snapshots().map((doc) => doc.data());
  }

  /// Call the onboardUser Cloud Function
  Future<void> onboardUser({
    String? phoneNumber,
    String? displayName,
    String? profileImageUrl,
    String? role,
  }) async {
    final HttpsCallable callable = _functions.httpsCallable('onboardUser');
    await callable.call({
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
      if (displayName != null) 'displayName': displayName,
      if (profileImageUrl != null) 'profileImageUrl': profileImageUrl,
      if (role != null) 'role': role,
    });
  }

  /// Upload a profile image to Firebase Storage with filename as UID
  Future<String> uploadProfileImage({
    required String uid,
    required List<int> imageBytes,
    required String contentType,
  }) async {
    final ref = _storage.ref().child('profile_images').child(uid);
    final metadata = SettableMetadata(contentType: contentType);
    final uploadTask = ref.putData(Uint8List.fromList(imageBytes), metadata);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  /// Direct Firestore update if needed (use carefully, prefer Cloud Functions for business logic)
  Future<void> updateUser(UserModel user) async {
    await _usersRef.doc(user.id).update(user.toFirestore());
  }
}

/// Provider for UserService
final userServiceProvider = Provider<UserService>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final functions = ref.watch(firebaseFunctionsProvider);
  final storage = ref.watch(firebaseStorageProvider);
  return UserService(firestore, functions, storage);
});
