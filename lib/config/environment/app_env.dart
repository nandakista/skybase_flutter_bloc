import 'package:skybase/app_configuration.dart';

import 'config_data.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
enum Environment {
  PRODUCTION,
  STAGING,
  DEVELOPMENT,
}

extension EnvExtension on Environment {
  bool get isStaging => this == Environment.STAGING;
  bool get isDev => this == Environment.DEVELOPMENT;
  bool get isProduction => this == Environment.PRODUCTION;
}

class AppEnv {
  static Config config = Config(
    baseUrl: AppConfiguration.devBaseUrl,
    tokenType: AppConfiguration.tokenType,
    clientToken: AppConfiguration.devClientToken,
  );
  static Environment env = Environment.DEVELOPMENT;

  static set(Environment environment) {
    env = environment;
    switch (environment) {
      case Environment.PRODUCTION:
        config = Config(
          baseUrl: AppConfiguration.prodBaseUrl,
          tokenType: AppConfiguration.tokenType,
          clientToken: AppConfiguration.prodClientToken,
        );
        break;
      case Environment.STAGING:
        config = Config(
          baseUrl: AppConfiguration.stagingBaseUrl,
          tokenType: AppConfiguration.tokenType,
          clientToken: AppConfiguration.stagingClientToken,
        );
        break;
      case Environment.DEVELOPMENT:
        config = Config(
          baseUrl: AppConfiguration.devBaseUrl,
          tokenType: AppConfiguration.tokenType,
          clientToken: AppConfiguration.devClientToken,
        );
        break;
    }
  }
}
