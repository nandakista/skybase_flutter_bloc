import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';

class SampleFeatureRepositoryImpl implements SampleFeatureRepository {
  String tag = 'SampleFeatureRepository::->';

  final SampleFeatureSources apiService;

  SampleFeatureRepositoryImpl({required this.apiService});

  @override
  Future<List<SampleFeature>> getUsers({
    required CancelToken cancelToken,
    required int page,
    required int perPage,
  }) async {
    try {
      return await apiService.getUsers(
        cancelToken: cancelToken,
        page: page,
        perPage: perPage,
      );
    } catch (e, stack) {
      log('$tag error = $e, $stack');
      rethrow;
    }
  }

  @override
  Future<SampleFeature> getDetailUser({
    required CancelToken cancelToken,
    required int id,
    required String username,
  }) async {
    try {
      final SampleFeature res = await apiService.getDetailUser(
        cancelToken: cancelToken,
        username: username,
      );
      res.followersList = await apiService.getFollowers(
        cancelToken: cancelToken,
        username: username,
      );
      res.followingList = await apiService.getFollowings(
        cancelToken: cancelToken,
        username: username,
      );
      res.repositoryList = await apiService.getRepos(
        cancelToken: cancelToken,
        username: username,
      );
      return res;
    } catch (e, stack) {
      log('$tag Failed get data $e, $stack');
      rethrow;
    }
  }
}
