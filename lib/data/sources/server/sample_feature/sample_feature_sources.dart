import 'package:dio/dio.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';

abstract interface class SampleFeatureSources {
  Future<List<SampleFeature>> getUsers({
    required CancelToken cancelToken,
    required int page,
    required int perPage,
    String? username,
  });

  Future<SampleFeature> getDetailUser({
    required CancelToken cancelToken,
    required String username,
  });

  Future<List<SampleFeature>> getFollowers({
    required CancelToken cancelToken,
    required String username,
  });

  Future<List<SampleFeature>> getFollowings({
    required CancelToken cancelToken,
    required String username,
  });

  Future<List<Repo>> getRepos({
    required CancelToken cancelToken,
    required String username,
  });
}
