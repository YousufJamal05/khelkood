// This source code was written for the khelkood monorepo.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  // Singleton instance as per google_sign_in 7.x
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isInitialized = false;

  AuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  User? get currentUser => _firebaseAuth.currentUser;

  /// Initialize Google Sign In.
  /// Note: When using Emulator, the Google UI still appears,
  /// but Firebase Auth redirects the final token to the local emulator.
  Future<void> initializeGoogleSignIn() async {
    if (_isInitialized) return;

    try {
      debugPrint('Initializing Google Sign In...');
      await _googleSignIn.initialize();

      try {
        await _googleSignIn.attemptLightweightAuthentication();
        debugPrint('✅ Google Sign In session restored');
      } catch (e) {
        debugPrint('No previous Google session found');
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('Error initializing Google Sign In: $e');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (!_isInitialized) await initializeGoogleSignIn();

      if (kIsWeb) {
        // Web flow: Uses the Firebase Popup directly
        final googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        googleProvider.addScope('profile');

        // This will automatically hit the emulator if useAuthEmulator was called
        return await _firebaseAuth.signInWithPopup(googleProvider);
      } else {
        // Mobile flow: Uses the native google_sign_in 7.x API
        if (!_googleSignIn.supportsAuthenticate()) {
          debugPrint('Platform does not support authenticate()');
          return null;
        }

        final account = await _googleSignIn.authenticate();
        final authentication = await account.authentication;

        // Authorization for scopes (AccessToken)
        final authorization =
            await account.authorizationClient.authorizationForScopes([
          'email',
          'profile',
        ]);

        if (authorization == null) {
          debugPrint('Failed to get authorization');
          return null;
        }

        final credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authorization.accessToken,
        );

        // Sign into Firebase (Emulator or Production based on main.dart config)
        return await _firebaseAuth.signInWithCredential(credential);
      }
    } catch (e) {
      if (e.toString().contains('canceled')) {
        debugPrint('User canceled Google Sign In');
        return null;
      }
      debugPrint("Error signing in with Google: $e");
      rethrow;
    }
  }

  // --- Phone Auth Methods (Emulator Compatible) ---

  Future<void> signInWithPhoneNumber(
    String phoneNumber, {
    required void Function(PhoneAuthCredential) onVerificationCompleted,
    required void Function(FirebaseAuthException) onVerificationFailed,
    required void Function(String, int?) onCodeSent,
    required void Function(String) onCodeAutoRetrievalTimeout,
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: onVerificationCompleted,
      verificationFailed: onVerificationFailed,
      codeSent: onCodeSent,
      codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
    );
  }

  Future<UserCredential> verifyOTP({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    if (!kIsWeb) {
      try {
        await _googleSignIn.signOut();
      } catch (e) {
        debugPrint('Error signing out from Google: $e');
      }
    }
  }
}
