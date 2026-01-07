import 'package:envied/envied.dart';

part 'envied_prod.g.dart';

/// Provides access to production environment variables using Envied.
@Envied(path: '../../env/.env.production')
abstract class ProdEnv {
  /// The firebase project id for production.
  @EnviedField(varName: 'FIREBASE_PROJECT_ID', obfuscate: true)
  static final String firebaseProjectId = _ProdEnv.firebaseProjectId;

  /// The firebase database url for production.
  @EnviedField(varName: 'FIREBASE_DATABASE_URL', obfuscate: true)
  static final String firebaseDatabaseUrl = _ProdEnv.firebaseDatabaseUrl;

  /// The firebase storage bucket for production.
  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET', obfuscate: true)
  static final String firebaseStorageBucket = _ProdEnv.firebaseStorageBucket;

  /// The firebase messaging sender id for production.
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID', obfuscate: true)
  static final String firebaseMessagingSenderId =
      _ProdEnv.firebaseMessagingSenderId;

  /// The firebase web api key for production.
  @EnviedField(varName: 'FIREBASE_WEB_API_KEY', obfuscate: true)
  static final String firebaseWebApiKey = _ProdEnv.firebaseWebApiKey;

  /// The firebase web app id for production.
  @EnviedField(varName: 'FIREBASE_WEB_APP_ID', obfuscate: true)
  static final String firebaseWebAppId = _ProdEnv.firebaseWebAppId;

  /// The firebase web auth domain for production.
  @EnviedField(varName: 'FIREBASE_WEB_AUTH_DOMAIN', obfuscate: true)
  static final String firebaseWebAuthDomain = _ProdEnv.firebaseWebAuthDomain;

  /// The firebase android api key for production.
  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY', obfuscate: true)
  static final String firebaseAndroidApiKey = _ProdEnv.firebaseAndroidApiKey;

  /// The firebase android app id for production.
  @EnviedField(varName: 'FIREBASE_ANDROID_APP_ID', obfuscate: true)
  static final String firebaseAndroidAppId = _ProdEnv.firebaseAndroidAppId;

  /// The firebase ios api key for production.
  @EnviedField(varName: 'FIREBASE_IOS_API_KEY', obfuscate: true)
  static final String firebaseIosApiKey = _ProdEnv.firebaseIosApiKey;

  /// The firebase ios app id for production.
  @EnviedField(varName: 'FIREBASE_IOS_APP_ID', obfuscate: true)
  static final String firebaseIosAppId = _ProdEnv.firebaseIosAppId;

  /// The firebase ios bundle id for production.
  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID', obfuscate: true)
  static final String firebaseIosBundleId = _ProdEnv.firebaseIosBundleId;

  /// The firebase cloud messaging vapid key for production.
  @EnviedField(varName: 'FCM_VAPID_KEY', obfuscate: true)
  static final String fcmVapidKey = _ProdEnv.fcmVapidKey;
  
}
