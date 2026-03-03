enum Environment { development, staging, production }

class Env {
  const Env._();

  static late Environment _environment;
  static late String _apiBaseUrl;

  static Environment get environment => _environment;
  static String get apiBaseUrl => _apiBaseUrl;

  static void init({
    required Environment environment,
    required String apiBaseUrl,
  }) {
    _environment = environment;
    _apiBaseUrl = apiBaseUrl;
  }

  static bool get isDevelopment => _environment == Environment.development;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;
}
