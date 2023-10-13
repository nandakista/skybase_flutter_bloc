import 'package:dio/dio.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';

abstract interface class SampleFeatureRepository {
  Future<List<SampleFeature>> getUsers({
    required CancelToken cancelToken,
    required int page,
    required int perPage,
  });

  Future<SampleFeature> getDetailUser({
    required CancelToken cancelToken,
    required int id,
    required String username,
  });
}
