import 'package:skybase/config/app/app_info.dart';
import 'package:skybase/config/network/api_token_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class AppConfiguration {
  //-- Main Configuration
  static const TokenType tokenType = TokenType.ACCESS_TOKEN;
  static const String prodBaseUrl = 'https://api.github.production.com';
  static const String stagingBaseUrl = 'https://api.github.staging.com';
  static const String devBaseUrl = 'https://api.github.com';

  //-- App Info
  static String appName = 'Skybase';
  static String appTag = 'Flutter Bloc';
  static String appVersion = AppInfo.packageInfo.version;
  static String buildNumber = AppInfo.packageInfo.buildNumber;
  static String packageName = AppInfo.packageInfo.packageName;

  static String get githubToken {
    const String key = String.fromEnvironment('GITHUB_TOKEN');
    if (key.isEmpty) {
      throw AssertionError('GITHUB_TOKEN is not defined');
    }
    return key;
  }
}