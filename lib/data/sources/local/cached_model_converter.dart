import 'package:json_annotation/json_annotation.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/models/user/user.dart';

bool typeEqual<S, T>() => S == T;

bool typeEqualN<S, T>() {
  return typeEqual<S, T>() || typeEqual<S?, T?>();
}

///
/// Every cache model must be registered here
///
class CachedModelConverter<T> implements JsonConverter<T, Object> {
  const CachedModelConverter();

  @override
  T fromJson(Object? json) {
    json = json as Map<String, dynamic>;
    if (typeEqualN<T, SampleFeature>()) {
      return SampleFeature.fromJson(json) as T;
    } else if (typeEqualN<T, User>()) {
      return User.fromJson(json) as T;
    } else if (typeEqualN<T, Repo>()) {
      return Repo.fromJson(json) as T;
    }
    ///
    /// Add other models
    ///
    ///
    throw UnimplementedError('`$T` fromJson factory unimplemented.');
  }

  @override
  Map<String, dynamic> toJson(T obj) {
    if (typeEqualN<T, SampleFeature>()) {
      return (obj as SampleFeature).toJson();
    } else if (typeEqualN<T, User>()) {
      return (obj as User).toJson();
    } else if (typeEqualN<T, Repo>()) {
      return (obj as Repo).toJson();
    }
    ///
    /// Add other models
    ///

    throw UnimplementedError('`$T` toJson factory unimplemented.');
  }
}
