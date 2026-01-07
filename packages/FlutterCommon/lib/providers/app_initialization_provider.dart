// This source code was written for the justpark monorepo.

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'device_info_provider.dart';
import 'firebase_provider.dart';

/// Combined initialization provider that handles both device info and Firebase setup
/// This eliminates the need for nested when() calls in the UI
final appInitializationProvider = FutureProvider<void>((ref) async {
  try {
    // Initialize device info first
    await ref.read(deviceInfoProvider.future);

    // Then initialize Firebase
    await ref.read(firebaseProvider.future);

    debugPrint('✅ App initialization completed successfully');
  } catch (e, stack) {
    debugPrint('App initialization failed: $e');
    debugPrint('Stack trace: $stack');
    rethrow;
  }
});
