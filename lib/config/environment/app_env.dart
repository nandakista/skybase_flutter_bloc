import 'package:flutter/material.dart';
import 'package:skybase/config/environment/app_configuration.dart';

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

  String get title => switch(this) {
    Environment.PRODUCTION => 'PROD',
    Environment.STAGING => 'STAGING',
    Environment.DEVELOPMENT => 'DEV',
  };

  Color get color => switch(this) {
    Environment.PRODUCTION => Colors.green,
    Environment.STAGING => Colors.purple,
    Environment.DEVELOPMENT => Colors.blue,
  };
}

class AppEnv {
  static Config config = Config(
    baseUrl: AppConfiguration.devBaseUrl,
    tokenType: AppConfiguration.tokenType,
    githubToken: AppConfiguration.githubToken,
  );
  static Environment env = Environment.DEVELOPMENT;

  static set(Environment environment) {
    env = environment;
    switch (environment) {
      case Environment.PRODUCTION:
        config = Config(
          baseUrl: AppConfiguration.prodBaseUrl,
          tokenType: AppConfiguration.tokenType,
          githubToken: AppConfiguration.githubToken,
        );
        break;
      case Environment.STAGING:
        config = Config(
          baseUrl: AppConfiguration.stagingBaseUrl,
          tokenType: AppConfiguration.tokenType,
          githubToken: AppConfiguration.githubToken,
        );
        break;
      case Environment.DEVELOPMENT:
        config = Config(
          baseUrl: AppConfiguration.devBaseUrl,
          tokenType: AppConfiguration.tokenType,
          githubToken: AppConfiguration.githubToken,
        );
        break;
    }
  }
}
