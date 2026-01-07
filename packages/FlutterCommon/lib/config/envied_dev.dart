import 'package:envied/envied.dart';

part 'envied_dev.g.dart';

/// Provides access to development environment variables using Envied.
@Envied(path: '../../env/.env.development')
abstract class DevEnv {
  /// The firebase project id for development.
  @EnviedField(varName: 'FIREBASE_PROJECT_ID', obfuscate: true)
  static final String firebaseProjectId = _DevEnv.firebaseProjectId;

  /// The firebase database url for development.
  @EnviedField(varName: 'FIREBASE_DATABASE_URL', obfuscate: true)
  static final String firebaseDatabaseUrl = _DevEnv.firebaseDatabaseUrl;

  /// The firebase storage bucket for development.
  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET', obfuscate: true)
  static final String firebaseStorageBucket = _DevEnv.firebaseStorageBucket;

  /// The firebase messaging sender id for development.
  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID', obfuscate: true)
  static final String firebaseMessagingSenderId =
      _DevEnv.firebaseMessagingSenderId;

  /// The firebase web api key for development.
  @EnviedField(varName: 'FIREBASE_WEB_API_KEY', obfuscate: true)
  static final String firebaseWebApiKey = _DevEnv.firebaseWebApiKey;

  /// The firebase web app id for development.
  @EnviedField(varName: 'FIREBASE_WEB_APP_ID', obfuscate: true)
  static final String firebaseWebAppId = _DevEnv.firebaseWebAppId;

  /// The firebase web auth domain for development.
  @EnviedField(varName: 'FIREBASE_WEB_AUTH_DOMAIN', obfuscate: true)
  static final String firebaseWebAuthDomain = _DevEnv.firebaseWebAuthDomain;

  /// The firebase android api key for development.
  @EnviedField(varName: 'FIREBASE_ANDROID_API_KEY', obfuscate: true)
  static final String firebaseAndroidApiKey = _DevEnv.firebaseAndroidApiKey;

  /// The firebase android app id for development.
  @EnviedField(varName: 'FIREBASE_ANDROID_APP_ID', obfuscate: true)
  static final String firebaseAndroidAppId = _DevEnv.firebaseAndroidAppId;

  /// The firebase ios api key for development.
  @EnviedField(varName: 'FIREBASE_IOS_API_KEY', obfuscate: true)
  static final String firebaseIosApiKey = _DevEnv.firebaseIosApiKey;

  /// The firebase ios app id for development.
  @EnviedField(varName: 'FIREBASE_IOS_APP_ID', obfuscate: true)
  static final String firebaseIosAppId = _DevEnv.firebaseIosAppId;

  /// The firebase ios bundle id for development.
  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID', obfuscate: true)
  static final String firebaseIosBundleId = _DevEnv.firebaseIosBundleId;

  /// The firebase cloud messaging vapid key for development.
  @EnviedField(varName: 'FCM_VAPID_KEY', obfuscate: true)
  static final String fcmVapidKey = _DevEnv.fcmVapidKey;
}
