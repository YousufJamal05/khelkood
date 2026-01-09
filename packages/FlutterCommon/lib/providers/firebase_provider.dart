// This source code was written for the khelkood monorepo.

import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/env_config.dart';
import '../config/firebase_options.dart';
import '../enums/env_key.dart';

/// Provider to initialize Firebase (runs once and caches result)
final firebaseProvider = FutureProvider<void>((ref) async {
  // Ensures that the default Firebase app is initialized.
  await _ensureFirebaseInitialized();

  // Configures Firebase to use local emulators or production services.
  // (Crashlytics/App Check) behaves consistently.
  await _configureEmulators();

  // Only meaningful off the web.
  if (!kIsWeb) {
    await _configureCrashlytics();
    await _activateAppCheck();
  }
});

/// Provider for FirebaseFirestore instance
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Provider for FirebaseAuth instance
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Provider for FirebaseFunctions instance
/// Ensures Firebase is initialized before creating the instance
final firebaseFunctionsProvider = Provider<FirebaseFunctions>((ref) {
  // Ensure Firebase initialization completes before creating Functions instance
  // This guarantees emulator configuration is done first
  // Use .future to properly wait for the FutureProvider to complete
  ref.watch(firebaseProvider.future);
  return FirebaseFunctions.instance;
});

/// Provider for FirebaseMessaging instance
final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

/// Provider for FirebaseStorage instance
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

/// Ensures that the default Firebase app is initialized.
///
/// This method initializes Firebase using the platform-specific options.
/// If the app is already initialized (i.e., a 'duplicate-app' error occurs),
/// it logs a message and continues without re-initializing. Any other
/// initialization errors are logged and rethrown.
///
/// Throws a [FirebaseException] or other [Exception] if initialization fails
/// for reasons other than a duplicate app.
Future<void> _ensureFirebaseInitialized() async {
  try {
    final app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase initialized:\n${app.options}');
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      debugPrint(
        'Default Firebase app already exists. Proceeding without re-initialization.',
      );
      // fall through
    } else {
      debugPrint('Firebase init error: $e');
      rethrow;
    }
  } catch (e) {
    debugPrint('Firebase init error: $e');
    rethrow;
  }
}

/// Configures Firebase to use local emulators in development mode, or production
/// services in production mode.
///
/// In development, this method connects Firebase Auth, Firestore, Realtime Database,
/// Storage, and Functions to their respective local emulators. It also disables
/// Crashlytics collection to avoid reporting development errors. In production,
/// Crashlytics collection is enabled and all Firebase services use their default
/// remote endpoints.
///
/// Any errors encountered while connecting to emulators in development are logged,
/// but do not prevent the app from continuing to run.
Future<void> _configureEmulators() async {
  if (EnvConfig.isDevEnv) {
    // Determine the correct hostname for emulator connections
    // Android emulators use 10.0.2.2 to access host machine's localhost
    // iOS simulators and web can use localhost
    String emulatorHost;
    if (kIsWeb) {
      emulatorHost = 'localhost';
    } else {
      try {
        if (Platform.isAndroid) {
          // Use LAN IP to support both Emulator (routed) and Physical Device
          emulatorHost = '10.0.2.2';
        } else {
          emulatorHost = 'localhost';
        }
      } catch (e) {
        debugPrint('🔵 FirebaseProvider: Failed to detect platform: $e');
        emulatorHost = 'localhost';
      }
    }

    debugPrint(
      '🔵 FirebaseProvider: Configuring emulators with host: $emulatorHost',
    );
    if (kIsWeb) {
      debugPrint('🔵 FirebaseProvider: Platform - Web: true');
    } else {
      try {
        debugPrint(
          '🔵 FirebaseProvider: Platform - Web: false, Android: ${Platform.isAndroid}, iOS: ${Platform.isIOS}',
        );
      } catch (e) {
        debugPrint(
          '🔵 FirebaseProvider: Platform - Web: false, Platform unavailable: $e',
        );
      }
    }

    try {
      // Auth
      debugPrint(
        '🔵 FirebaseProvider: Configuring Auth emulator on $emulatorHost:9099',
      );
      await FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);
      await FirebaseAuth.instance.setSettings(
        appVerificationDisabledForTesting: true,
      );
      debugPrint('✅ FirebaseProvider: Auth emulator configured');

      // Firestore
      debugPrint(
        '🔵 FirebaseProvider: Configuring Firestore emulator on $emulatorHost:8081',
      );
      FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8081);
      debugPrint('✅ FirebaseProvider: Firestore emulator configured');

      // Realtime Database
      debugPrint(
        '🔵 FirebaseProvider: Configuring Realtime Database emulator on $emulatorHost:9001',
      );
      if (kIsWeb) {
        final databaseUrl = EnvConfig.get(EnvKey.firebaseDatabaseUrl);
        FirebaseDatabase.instanceFor(
          app: Firebase.app(),
          databaseURL: databaseUrl,
        ).useDatabaseEmulator(emulatorHost, 9001);
      } else {
        FirebaseDatabase.instance.useDatabaseEmulator(emulatorHost, 9001);
      }
      debugPrint('✅ FirebaseProvider: Realtime Database emulator configured');

      // Storage
      debugPrint(
        '🔵 FirebaseProvider: Configuring Storage emulator on $emulatorHost:9198',
      );
      await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9198);
      debugPrint('✅ FirebaseProvider: Storage emulator configured');

      // Functions - CRITICAL: Must be configured before any function calls
      debugPrint(
        '🔵 FirebaseProvider: Configuring Functions emulator on $emulatorHost:5001',
      );
      debugPrint(
        '🔵 FirebaseProvider: This MUST be done before any function calls',
      );
      try {
        FirebaseFunctions.instance.useFunctionsEmulator(emulatorHost, 5001);
        debugPrint(
          '✅ FirebaseProvider: Functions emulator configured successfully',
        );
        debugPrint(
          '🔵 FirebaseProvider: Functions will route to: http://$emulatorHost:5001',
        );
      } catch (e) {
        debugPrint(
          '❌ FirebaseProvider: Failed to configure Functions emulator: $e',
        );
        // Rethrow to prevent silent failures
        rethrow;
      }
      debugPrint(
        '✅ FirebaseProvider: All Firebase Emulators configured successfully',
      );
      debugPrint('🔵 FirebaseProvider: Emulator endpoints:');
      debugPrint('   - Auth: $emulatorHost:9099');
      debugPrint('   - Firestore: $emulatorHost:8081');
      debugPrint('   - Realtime DB: $emulatorHost:9001');
      debugPrint('   - Storage: $emulatorHost:9198');
      debugPrint('   - Functions: $emulatorHost:5001');
    } catch (e, stack) {
      debugPrint(
        '❌ FirebaseProvider: Failed to connect to Firebase emulators: $e',
      );
      debugPrint('❌ FirebaseProvider: Stack trace: $stack');
      // Don't rethrow in dev; allow app to continue.
    }
    return;
  } else {
    // Production
    debugPrint('🔵 FirebaseProvider: Running Firebase in production mode…');
    if (!kIsWeb) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  }
}

/// Configures global error forwarding to Firebase Crashlytics.
///
/// This method sets up handlers to forward all uncaught Flutter framework errors
/// and platform dispatcher (zone) errors to Firebase Crashlytics for reporting.
/// If configuration fails, the error is logged but the app continues running.
///
/// This should be called after Firebase initialization and before any errors
/// might occur in the app lifecycle.
Future<void> _configureCrashlytics() async {
  try {
    // Forward Flutter framework errors
    FlutterError.onError = (details) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    };

    // Forward uncaught zone errors
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    debugPrint('Firebase Crashlytics error handling configured.');
  } catch (e, stack) {
    debugPrint('Failed to configure Firebase Crashlytics: $e');
    debugPrint('Stack trace: $stack');
    // Non-fatal; continue.
  }
}

/// Activates Firebase App Check for the current environment.
///
/// In development/emulator mode, App Check is skipped because:
/// 1. Firebase emulators automatically bypass App Check enforcement
/// 2. App Check requires additional setup (debug tokens, etc.) that's not needed for emulators
/// 3. This simplifies the development workflow
///
/// In production, App Check is activated with platform-specific providers to ensure
/// device integrity and protect backend resources from abuse.
///
/// This should be called after Firebase initialization and before making any requests
/// that require App Check protection.
Future<void> _activateAppCheck() async {
  // In development/debug mode, activate with the Debug Provider
  if (EnvConfig.isDevEnv || kDebugMode) {
    debugPrint(
      'ℹ️  FirebaseProvider: Activating App Check with Debug Provider',
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
    );
    return;
  }

  // Production: Activate App Check with platform-specific providers
  try {
    debugPrint(
      '🔵 FirebaseProvider: Activating App Check with production providers',
    );
    await FirebaseAppCheck.instance.activate();
    await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
    debugPrint(
      '✅ FirebaseProvider: App Check activated (production providers).',
    );
  } catch (e, stack) {
    debugPrint('❌ FirebaseProvider: Failed to activate Firebase App Check: $e');
    debugPrint('❌ FirebaseProvider: Stack trace: $stack');
    debugPrint(
      '❌ FirebaseProvider: CRITICAL: Firebase App Check failed in production.',
    );
    rethrow;
  }
}
