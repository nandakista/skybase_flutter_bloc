import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skybase/service_locator.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
FlutterSecureStorage secureStorage = sl<FlutterSecureStorage>();

class SecureStorageManager {
  static SecureStorageManager get instance => sl<SecureStorageManager>();

  final String _tokenKey = 'token';
  final String _refreshTokenKey = 'refresh_token';

  Future<bool> isLoggedIn() async {
    return (await getToken() != '');
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: _tokenKey);
  }

  Future setToken({required String? value}) async {
    return await secureStorage.write(key: _tokenKey, value: value);
  }

  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: _refreshTokenKey);
  }

  Future setRefreshToken({required String? value}) async {
    return await secureStorage.write(key: _refreshTokenKey, value: value);
  }

  Future logout() async {
    await setToken(value: '');
    await setRefreshToken(value: '');
  }
}
