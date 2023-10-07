import 'package:flutter/foundation.dart';
import 'package:skybase/config/network/api_request.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';

class SampleFeatureSourcesImpl implements SampleFeatureSources {
  String tag = 'SampleFeatureApiImpl::->';

  @override
  Future<List<SampleFeature>> getUsers({
    required int page,
    required int perPage,
  }) async {
    try {
      var url = '/search/users?';
      url += 'q=nanda&';
      url += 'page=$page&';
      url += 'per_page=$perPage';
      final res = await ApiRequest.get(
        url: url,
        useToken: true,
      );
      return (res.data['items'] as List)
          .map((data) => SampleFeature.fromJson(data))
          .toList()
          .cast<SampleFeature>();
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<SampleFeature> getDetailUser({required String username}) async {
    try {
      final res = await ApiRequest.get(
        url: '/users/$username',
        useToken: true,
      );
      return SampleFeature.fromJson(res.data);
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<SampleFeature>> getFollowers({required String username}) async {
    try {
      final res = await ApiRequest.get(
        url: '/users/$username/followers',
        useToken: true,
      );
      return (res.data as List)
          .map((data) => SampleFeature.fromJson(data))
          .toList()
          .cast<SampleFeature>();
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<SampleFeature>> getFollowings({required String username}) async {
    try {
      final res = await ApiRequest.get(
        url: '/users/$username/following',
        useToken: true,
      );
      return (res.data as List)
          .map((data) => SampleFeature.fromJson(data))
          .toList()
          .cast<SampleFeature>();
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<Repo>> getRepos({required String username}) async {
    try {
      final res = await ApiRequest.get(
        url: '/users/$username/repos?type=all',
        useToken: true,
      );
      return (res.data as List)
          .map((data) => Repo.fromJson(data))
          .toList()
          .cast<Repo>();
      // return List<Repo>.from(_res.data.map((data) => Repo.fromJson(data)));
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }
}
