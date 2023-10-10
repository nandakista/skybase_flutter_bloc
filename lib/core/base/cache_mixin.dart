import 'dart:convert';
import 'dart:developer';

import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/extension/string_extension.dart';
import 'package:skybase/data/sources/local/cached_model_converter.dart';

mixin CacheMixin {
  String cachedTag = 'CacheMixin::->';

  StorageManager storage = StorageManager.find;

  /// Save list data in cache, only in saving page 1.
  /// **[cachedKey]** is identifier cached data
  Future<List<T>> getCacheList<T>({
    required String cachedKey,
    required int page,
    required Future<List<T>> Function() onLoad,
  }) async {
    List<T> result = [];
    log('$cachedTag page = $page');
    if (page == 1) {
      dynamic cache = storage.get(cachedKey);
      if (storage.has(cachedKey) && cache.toString().isNotEmpty) {
        log('$cachedTag get cache');

        /// Refresh data so the cache is always actual data
        _saveCacheList(cachedKey: cachedKey, onLoad: onLoad);

        result = List<T>.from(
          (json.decode(cache) as List).map(
            (x) => CachedModelConverter<T>().fromJson(x),
          ),
        );
      } else {
        result = await _saveCacheList(cachedKey: cachedKey, onLoad: onLoad);
      }
    } else {
      result = await onLoad();
    }

    return result;
  }

  Future<List<T>> _saveCacheList<T>({
    required String cachedKey,
    required Future<List<T>> Function() onLoad,
  }) async {
    log('$cachedTag Load & save cache data');
    List<T> result = await onLoad();
    await storage.save<String>(cachedKey, json.encode(result));
    return result;
  }

  /// Save object data to cache.
  ///
  /// **[cachedKey]** is identifier cached data
  ///
  /// **[cachedId]** is id of your data, if you need to save every object
  /// data in list, you should fill [cachedId] with your data id.
  ///
  /// But if you only want save the last object you can leave [cachedId] null.
  Future<T> getCache<T>({
    required String cachedKey,
    required Future<T> Function() onLoad,
    required String? cachedId,
    String? dataId,
  }) async {
    T result;
    String key = cachedKey;
    if (cachedId != null) key += cachedId.toString();
    dynamic cache = await storage.get(key);

    log('$cachedTag cache data = $cache');
    if (storage.has(key) && cache.toString().isNotNullAndNotEmpty) {
      Map<String, dynamic> cacheMap = json.decode(cache);

      if (cachedId == _getId(cache: cacheMap, dataId: dataId)) {
        log('$cachedTag get cache');
        /// Refresh data so the cache is always actual data
        _saveCache(cachedKey: key, onLoad: onLoad);

        result = CachedModelConverter<T>().fromJson(cacheMap);
      } else {
        log('$cachedTag cache is not equal with data');
        result = await _saveCache(cachedKey: key, onLoad: onLoad);
      }
    } else {
      result = await _saveCache(cachedKey: key, onLoad: onLoad);
    }
    return result;
  }

  String _getId({
    required Map<String, dynamic> cache,
    String? dataId,
  }) {
    if (dataId != null) return dataId.toString();
    return (cache['id']).toString();
  }

  Future<T> _saveCache<T>({
    required String cachedKey,
    required Future<T> Function() onLoad,
  }) async {
    log('$cachedTag Load & save cache data');
    T result = await onLoad();
    await storage.save<String>(
      cachedKey,
      json.encode(CachedModelConverter<T>().toJson(result)),
    );
    return result;
  }
}
