import 'package:skybase/config/app/app_info.dart';
import 'package:skybase/config/network/api_token_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class AppConfiguration {
  //-- Main Configuration
  static const tokenType = TokenType.ACCESS_TOKEN;

  /// TODO: To test this repository you can change this clientToken to Github token
  /// You can get github token with : Profile > Settings > Developer Settings > Personal access tokens

  //-- Production
  static const prodBaseUrl = 'https://api.github.production.com';
  static const prodClientToken = 'Some Client Token';

  //-- Staging
  static const stagingBaseUrl = 'https://api.github.staging.com';
  static const stagingClientToken = 'Some Client Token';

  //-- Development
  static const devBaseUrl = 'https://api.github.com';
  static const devClientToken = 'Some Client Token';

  //-- App Info
  static String appName = 'Skybase';
  static String appTag = 'Flutter Bloc';
  static String appVersion = AppInfo.packageInfo.version;
  static String buildNumber = AppInfo.packageInfo.buildNumber;
  static String packageName = AppInfo.packageInfo.packageName;
}