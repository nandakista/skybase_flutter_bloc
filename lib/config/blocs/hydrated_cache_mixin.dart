/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'dart:developer';

import 'package:skybase/data/sources/local/cached_model_converter.dart';

mixin HydratedCacheMixin<T> {
  final String _tag = 'CacheMixin::->';

  /// Hydrated Bloc helper for saving data object into cache
  /// Should called in toJson hydrated
  Map<String, dynamic>? saveCache(T data) {
    try {
      return CachedModelConverter<T>().toJson(data);
    } catch (e, stack) {
      log('$_tag Error save cache, error = $e, $stack');
      return null;
    }
  }

  /// Hydrated Bloc helper for get data object cache
  /// should called in fromJson hydrated
  T loadCache(Map<String, dynamic> json) {
    try {
      return CachedModelConverter<T>().fromJson(json);
    } catch (e, stack) {
      log('$_tag Error load cache, error = $e, $stack');
      throw Exception('$_tag Failed when load cache');
    }
  }

  /// Hydrated Bloc helper for saving data list into cache
  /// Should called in toJson hydrated
  Map<String, dynamic>? saveCacheList(List<T> data) {
    try {
      return {
        'data': List.from(
          data.map((x) => CachedModelConverter<T>().toJson(x)),
        ),
      };
    } catch (e, stack) {
      log('$_tag Error save cache, error = $e, $stack');
      return null;
    }
  }

  /// Hydrated Bloc helper for get data list cache
  /// should called in fromJson hydrated
  List<T> loadCacheList(Map<String, dynamic> json) {
    try {
      return ((json['data'] as List?) ?? [])
          .map((e) => CachedModelConverter<T>().fromJson(e))
          .toList();
    } catch (e, stack) {
      log('$_tag Error load cache, error = $e, $stack');
      return [];
    }
  }
}
