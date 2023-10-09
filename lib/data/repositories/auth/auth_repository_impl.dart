import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/sources/server/auth/auth_sources.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSources apiService;

  AuthRepositoryImpl({required this.apiService});

  String tag = 'AuthRepositoryImpl::->';

  @override
  Future<User> login({
    required String phoneNumber,
    required String email,
    required String password,
  }) async {
    return await apiService.login(
      phoneNumber: phoneNumber,
      email: email,
      password: password,
    );
  }

  @override
  Future<User> verifyToken({
    required int userId,
    required String token,
  }) async {
    return await apiService.verifyToken(userId: userId, token: token);
  }

  @override
  Future<User> getProfile({required String username}) async {
    return await apiService.getProfile(username: username);
  }

  @override
  Future<List<Repo>> getProfileRepository({required String username}) async {
    return await apiService.getProfileRepository(username: username);
  }
}
