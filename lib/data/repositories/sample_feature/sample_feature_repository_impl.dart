import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:skybase/config/base/cache_mixin.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';

class SampleFeatureRepositoryImpl
    with CacheMixin
    implements SampleFeatureRepository {
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
      // Using cached
      return await getCacheList(
        cachedKey: CachedKey.SAMPLE_FEATURE_LIST,
        page: page,
        onLoad: () async => await apiService.getUsers(
          cancelToken: cancelToken,
          page: page,
          perPage: perPage,
        ),
      );

      // Without cache
      // return await apiService.getUsers(page: page, perPage: perPage);
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
      // Using cache
      return await getCache(
        cachedKey: CachedKey.SAMPLE_FEATURE_DETAIL,
        cachedId: id.toString(),
        onLoad: () async => await apiService
            .getDetailUser(cancelToken: cancelToken, username: username)
            .then(
          (res) async {
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
          },
        ),
      );

      // Without Cache
      // final SampleFeature res = await apiService.getDetailUser(username: username);
      // res.followersList = await apiService.getFollowers(username: username);
      // res.followingList = await apiService.getFollowings(username: username);
      // res.repositoryList = await apiService.getRepos(username: username);
      // return res;
    } catch (e, stack) {
      log('$tag Failed get data $e, $stack');
      rethrow;
    }
  }
}
