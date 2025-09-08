import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:skybase/config/network/api_request.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';

class SampleFeatureSourcesImpl implements SampleFeatureSources {
  String tag = 'SampleFeatureApiImpl::->';

  @override
  Future<List<SampleFeature>> getUsers({
    required CancelToken cancelToken,
    required int page,
    required int perPage,
    String? username,
  }) async {
    try {
      final res = await ApiRequest.get(
        url: '/search/users',
        queryParameters: {
          'q': username ?? 'nanda',
          'page': page,
          'per_page': perPage,
        },
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
  Future<SampleFeature> getDetailUser({
    required CancelToken cancelToken,
    required String username,
  }) async {
    try {
      final res = await ApiRequest.get(
        url: '/users/$username',
      );
      return SampleFeature.fromJson(res.data);
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<SampleFeature>> getFollowers({
    required CancelToken cancelToken,
    required String username,
  }) async {
    try {
      final res = await ApiRequest.get(
        url: '/users/$username/followers',
      );
      return List<SampleFeature>.from(
        (res.data as List).map((data) => SampleFeature.fromJson(data)),
      );
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<SampleFeature>> getFollowings({
    required CancelToken cancelToken,
    required String username,
  }) async {
    try {
      final res = await ApiRequest.get(
        url: '/users/$username/following',
      );
      return List<SampleFeature>.from(
        (res.data as List).map((data) => SampleFeature.fromJson(data)),
      );
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }

  @override
  Future<List<Repo>> getRepos({
    required CancelToken cancelToken,
    required String username,
  }) async {
    try {
      final res = await ApiRequest.get(
        url: '/users/$username/repos',
        queryParameters: {'type': 'all'},
      );
      return List<Repo>.from(
        (res.data as List).map((data) => Repo.fromJson(data)),
      );
    } catch (e) {
      debugPrint('$tag Error = $e');
      rethrow;
    }
  }
}
