import '../enums/env_key.dart';
import 'envied_dev.dart';
import 'envied_prod.dart';

/// Provides environment-specific configuration and access to environment variables.
class EnvConfig {
  /// The current app flavor (e.g., 'development', 'staging', 'production', 'test').
  static const String _flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'development',
  );

  /// Cached environment map for the current flavor.
  static final Map<EnvKey, String> _env = _loadEnv();

  /// Loads the environment variables for the current flavor.
  ///
  /// Throws an [UnsupportedError] if the flavor is not supported.
  static Map<EnvKey, String> _loadEnv() {
    switch (_flavor) {
      case 'development':
        return {
          EnvKey.firebaseProjectId: DevEnv.firebaseProjectId,
          EnvKey.firebaseDatabaseUrl: DevEnv.firebaseDatabaseUrl,
          EnvKey.firebaseStorageBucket: DevEnv.firebaseStorageBucket,
          EnvKey.firebaseMessagingSenderId: DevEnv.firebaseMessagingSenderId,
          EnvKey.firebaseWebApiKey: DevEnv.firebaseWebApiKey,
          EnvKey.firebaseWebAppId: DevEnv.firebaseWebAppId,
          EnvKey.firebaseWebAuthDomain: DevEnv.firebaseWebAuthDomain,
          EnvKey.firebaseAndroidApiKey: DevEnv.firebaseAndroidApiKey,
          EnvKey.firebaseAndroidAppId: DevEnv.firebaseAndroidAppId,
          EnvKey.firebaseIosApiKey: DevEnv.firebaseIosApiKey,
          EnvKey.firebaseIosAppId: DevEnv.firebaseIosAppId,
          EnvKey.firebaseIosBundleId: DevEnv.firebaseIosBundleId,
          EnvKey.fcmVapidKey: DevEnv.fcmVapidKey,
        };
      case 'production':
        return {
          EnvKey.firebaseProjectId: ProdEnv.firebaseProjectId,
          EnvKey.firebaseDatabaseUrl: ProdEnv.firebaseDatabaseUrl,
          EnvKey.firebaseStorageBucket: ProdEnv.firebaseStorageBucket,
          EnvKey.firebaseMessagingSenderId: ProdEnv.firebaseMessagingSenderId,
          EnvKey.firebaseWebApiKey: ProdEnv.firebaseWebApiKey,
          EnvKey.firebaseWebAppId: ProdEnv.firebaseWebAppId,
          EnvKey.firebaseWebAuthDomain: ProdEnv.firebaseWebAuthDomain,
          EnvKey.firebaseAndroidApiKey: ProdEnv.firebaseAndroidApiKey,
          EnvKey.firebaseAndroidAppId: ProdEnv.firebaseAndroidAppId,
          EnvKey.firebaseIosApiKey: ProdEnv.firebaseIosApiKey,
          EnvKey.firebaseIosAppId: ProdEnv.firebaseIosAppId,
          EnvKey.firebaseIosBundleId: ProdEnv.firebaseIosBundleId,
          EnvKey.fcmVapidKey: ProdEnv.fcmVapidKey,
        };
      default:
        throw UnsupportedError('⚠️ Unsupported flavor:$_flavor');
    }
  }

  /// Returns the value for the given [key] from the environment.
  ///
  /// Throws an [Exception] if the key is not found for the current flavor.
  static String get(EnvKey key) {
    final value = _env[key];
    if (value == null) {
      throw Exception(
        '❌ Env key "${key.name}" not found for flavor "$_flavor"',
      );
    }
    return value;
  }

  /// Returns true if the current environment is development
  static bool get isDevEnv => _flavor == 'development';

  /// Returns true if the current environment is production
  static bool get isProdEnv => _flavor == 'production';
}
