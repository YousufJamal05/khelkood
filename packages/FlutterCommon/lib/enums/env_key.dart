import '../config/env_config.dart';

/// The keys for environment variables used in the application.
enum EnvKey {
  /// Firebase project ID for the application
  firebaseProjectId,

  /// Firebase Realtime Database URL
  firebaseDatabaseUrl,

  /// Firebase Storage bucket name
  firebaseStorageBucket,

  /// Firebase Cloud Messaging sender ID
  firebaseMessagingSenderId,

  /// Firebase Web API key
  firebaseWebApiKey,

  /// Firebase Web app ID
  firebaseWebAppId,

  /// Firebase Web auth domain
  firebaseWebAuthDomain,

  /// Firebase Android API key
  firebaseAndroidApiKey,

  /// Firebase Android app ID
  firebaseAndroidAppId,

  /// Firebase iOS API key
  firebaseIosApiKey,

  /// Firebase iOS app ID
  firebaseIosAppId,

  /// Firebase iOS bundle ID
  firebaseIosBundleId,

  /// Firebase Cloud Messaging VAPID key
  fcmVapidKey
}

/// Extension to provide value access for [EnvKey].
extension EnvKeyExtension on EnvKey {
  /// Returns the value for the environment key from [EnvConfig].
  String get value => EnvConfig.get(this);
}
