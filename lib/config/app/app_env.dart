import 'package:skybase/app_configuration.dart';
import 'package:skybase/config/network/api_token_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
enum Env {
  PRODUCTION,
  STAGING,
  DEVELOPMENT,
}

class AppEnv {
  static Config config = Config(
    baseUrl: AppConfiguration.devBaseUrl,
    tokenType: AppConfiguration.tokenType,
    clientToken: AppConfiguration.devClientToken,
  );
  static Env env = Env.DEVELOPMENT;

  static set(Env environment) {
    env = environment;
    switch (environment) {
      case Env.PRODUCTION:
        config = Config(
          baseUrl: AppConfiguration.prodBaseUrl,
          tokenType: AppConfiguration.tokenType,
          clientToken: AppConfiguration.prodClientToken,
        );
        break;
      case Env.STAGING:
        config = Config(
          baseUrl: AppConfiguration.stagingBaseUrl,
          tokenType: AppConfiguration.tokenType,
          clientToken: AppConfiguration.stagingClientToken,
        );
        break;
      case Env.DEVELOPMENT:
        config = Config(
          baseUrl: AppConfiguration.devBaseUrl,
          tokenType: AppConfiguration.tokenType,
          clientToken: AppConfiguration.devClientToken,
        );
        break;
    }
  }
}

class Config {
  Config({
    required this.baseUrl,
    required this.clientToken,
    required this.tokenType,
  });

  String baseUrl;
  String clientToken;
  TokenType tokenType;
}
