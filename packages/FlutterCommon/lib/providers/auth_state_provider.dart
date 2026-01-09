// This source code was written for the khelkood monorepo.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../providers/firebase_provider.dart';
import '../services/auth_service.dart';

/// Provider for the AuthService instance
final authServiceProvider = Provider<AuthService>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthService(firebaseAuth);
});

/// Stream of the current Firebase User
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

/// Stream of the current UserModel from Firestore
/// This requires the user to be logged in and a Firestore document to exist
final currentUserProvider = StreamProvider<UserModel?>((ref) {
  final authState = ref.watch(authStateProvider);
  final firestore = ref.watch(firestoreProvider);

  return authState.when(
    data: (user) {
      if (user == null) {
        return Stream.value(null);
      }
      return firestore
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snapshot) {
        if (!snapshot.exists) return null;
        return UserModel.fromFirestore(snapshot, null);
      });
    },
    loading: () => const Stream.empty(),
    error: (_, __) => Stream.value(null),
  );
});
