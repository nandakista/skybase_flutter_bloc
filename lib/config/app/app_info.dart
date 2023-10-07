import 'package:package_info_plus/package_info_plus.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class AppInfo {
  static late PackageInfo packageInfo;

  static setInfo(PackageInfo info) {
    packageInfo = info;
  }
}