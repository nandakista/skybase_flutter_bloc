import 'dart:convert';
import 'dart:developer';

import 'package:skybase/core/database/storage/cache_data.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/extension/string_extension.dart';
import 'package:skybase/data/sources/local/cached_model_converter.dart';

mixin CacheMixin {
  String cachedTag = 'CacheMixin::->';

  StorageManager storage = StorageManager.instance;

  /// Save list data in cache, only in saving page 1.
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

        CacheData cacheData = CacheData.fromJson(jsonDecode(cache));
        result = List<T>.from(
          (json.decode(cacheData.value) as List).map(
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
    await storage.save<String>(
      cachedKey,
      jsonEncode(
        CacheData(value: json.encode(result)),
      ),
    );
    return result;
  }

  /// Save object data to cache.
  ///
  /// Set **[onlyCacheLast]** to true if you want to cache only the last data you've open.
  ///
  /// Set **[customFieldId]** to your actual data id if your data id is not using "id".
  /// For example: the id of user data is user_id
  Future<T> getCache<T>({
    required String cachedKey,
    required Future<T> Function() onLoad,
    required String? cachedId,
    bool onlyCacheLast = false,
    String? customFieldId,
  }) async {
    T result;
    String key = cachedKey;
    if (!onlyCacheLast) key = '$cachedKey/$cachedId';
    log('$cachedTag cached key = $key');
    dynamic cache = await storage.get(key);

    if (storage.has(key) && cache.toString().isNotNullAndNotEmpty) {
      CacheData cacheData = CacheData.fromJson(jsonDecode(cache));
      Map<String, dynamic> cacheMap = cacheData.value as Map<String, dynamic>;
      if (cachedId == _getId(cache: cacheMap, customFieldId: customFieldId)) {
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
    String? customFieldId,
  }) {
    if (customFieldId != null) return customFieldId.toString();
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
      jsonEncode(
        CacheData(value: result).toJson(),
      ),
    );
    return result;
  }
}
