import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';

abstract interface class SampleFeatureSources {
  Future<List<SampleFeature>> getUsers({required int page, required int perPage});
  Future<SampleFeature> getDetailUser({required String username});
  Future<List<SampleFeature>> getFollowers({required String username});
  Future<List<SampleFeature>> getFollowings({required String username});
  Future<List<Repo>> getRepos({required String username});
}