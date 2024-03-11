/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'dart:developer';

import 'package:skybase/config/base/cache_mixin.dart';

abstract class BaseRepository with CacheMixin {
  final String _tag = 'BaseRepository::->';

  /// Save list data in cache, only saving for page 1
  Future<List<T>> loadCachedList<T>({
    required String cachedKey,
    required int page,
    required Future<List<T>> Function() onLoad,
  }) async {
    try {
      List<T> result = [];
      log('$_tag page = $page');
      if (page == 1) {
        result = await getCachedList(key: cachedKey);
        if (result.isNotEmpty) {
          onLoad().then((value) => saveCachedList(key: cachedKey, list: value));
          return result;
        } else {
          result = await onLoad();
          await saveCachedList(key: cachedKey, list: result);
          return result;
        }
      } else {
        result = await onLoad();
        return result;
      }
    } catch (e, stackTrace) {
      log('$_tag error $e, $stackTrace');
      rethrow;
    }
  }

  /// Save object data to cache.
  ///
  /// Set **[onlyCacheLast]** to true if you want to cache only the last data you've open.
  ///
  /// Set **[customFieldId]** to your actual data id if your data id is not using "id".
  /// For example: the id of user data is user_id
  Future<T> loadCached<T>({
    required String cachedKey,
    required Future<T> Function() onLoad,
    required String? cachedId,
    bool onlyCacheLast = false,
    String? customFieldId,
  }) async {
    try {
      String key = cachedKey;
      if (!onlyCacheLast) key = '$cachedKey/$cachedId';
      T? cacheData = await getCacheObject(
        key: key,
        cachedId: cachedId,
        customFieldId: customFieldId,
      );
      if (cacheData != null) {
        onLoad().then((value) => saveCachedObject(key: key, data: value));
        return cacheData;
      } else {
        final response = await onLoad();
        await saveCachedObject(key: key, data: response);
        return response;
      }
    } catch (e, stackTrace) {
      log('$_tag error $e, $stackTrace');
      rethrow;
    }
  }
}
