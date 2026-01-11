// This source code was written for the khelkood monorepo.

import 'dart:async';
import 'package:common/providers/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common/services/user_service.dart';

class CompleteProfileNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    // Initial state is idle
  }

  Future<void> onboard({
    required String displayName,
    required String role,
    String? email,
    List<int>? imageBytes,
    String? contentType,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final userService = ref.read(userServiceProvider);
      final firebaseAuth = ref.read(firebaseAuthProvider);
      final user = firebaseAuth.currentUser;
      final uid = user?.uid;

      if (uid == null) throw Exception("User not authenticated");

      String? profileImageUrl;
      if (imageBytes != null && contentType != null) {
        profileImageUrl = await userService.uploadProfileImage(
          uid: uid,
          imageBytes: imageBytes,
          contentType: contentType,
        );
      }

      await userService.onboardUser(
        phoneNumber: user?.phoneNumber ?? "",
        displayName: displayName,
        profileImageUrl: profileImageUrl,
        role: role,
        email: email,
      );
    });
  }
}

final completeProfileProvider =
    AsyncNotifierProvider<CompleteProfileNotifier, void>(() {
      return CompleteProfileNotifier();
    });
