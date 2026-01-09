// This source code was written for the khelkood monorepo.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart' as gsi;

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

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

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider googleProvider = GoogleAuthProvider();
        return await _firebaseAuth.signInWithPopup(googleProvider);
      } else {
        final gsi.GoogleSignIn googleSignIn = gsi.GoogleSignIn(
          scopes: ['email', 'profile'],
        );
        final gsi.GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();

        if (googleSignInAccount != null) {
          final gsi.GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;

          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          return await _firebaseAuth.signInWithCredential(credential);
        }
      }
    } catch (e) {
      debugPrint("Error signing in with Google: $e");
      rethrow;
    }
    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    if (!kIsWeb) {
      await gsi.GoogleSignIn(scopes: ['email', 'profile']).signOut();
    }
  }
}
