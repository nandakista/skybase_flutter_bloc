import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skybase/data/sources/local/cached_model_converter.dart';
import 'package:skybase/core/database/get_storage/storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
abstract class BaseController<T> extends GetxController {
  StorageManager storage = StorageManager.find;

  RxBool loadingStatus = false.obs;
  RxString errorMessage = ''.obs;

  int perPage = 30;
  int page = 1;

  final dataObj = Rxn<T>();
  RxList<T> dataList = RxList<T>([]);

  bool get isLoading => loadingStatus.isTrue;

  bool get isError => errorMessage.value.isNotEmpty;

  bool get isEmpty => dataList.isEmpty && dataObj.value == null;

  bool get isSuccess => !isEmpty && !isError && !isLoading;

  /// **NOTE:**
  /// Must be implemented when you cached object data,
  /// optional when you cached list data
  String get cachedId;

  String get cachedKey;

  /// **NOTE:**
  /// call this [refreshPage] instead of [onRefresh] when you need to dispose anything
  void refreshPage() {}

  void onRefresh() async {
    try {
      await storage.delete(cachedKey);
      _resetData();
      refreshPage();
    } on UnimplementedError {
      debugPrint('BaseController::--> Cached Data not active');
      _resetData();
      refreshPage();
    } catch (e) {
      debugPrint('BaseController::--> Error $e');
    }
  }

  void _resetData() {
    dataObj.value = null;
    dataList.clear();
  }

  void showLoading() {
    loadingStatus.value = true;
    errorMessage.value = '';
  }

  void dismissLoading() => loadingStatus.value = false;

  void showError(String message) {
    errorMessage.value = message;
    dismissLoading();
  }

  void loadData(Function() onLoad) {
    onLoad();
  }

  /// **NOTE:**
  /// make sure you call this method at initial state,
  /// before you call method [saveCacheAndFinish]
  Future<void> getCache(Function() onLoad) async {
    var cache = storage.get(cachedKey);
    onLoad();
    if (storage.has(cachedKey) && cache.toString().isNotEmpty) {
      if (cache is String) {
        dataList.value = List<T>.from(
          (json.decode(cache) as List).map(
            (x) => CachedModelConverter<T>().fromJson(x),
          ),
        );
        dismissLoading();
      } else {
        if (cachedId == getId(cache)) {
          dataObj.value = CachedModelConverter<T>().fromJson(cache);
          dismissLoading();
        }
      }
    }
  }

  String getId(Map<String, dynamic> cache) {
    return (cache['id']).toString();
  }

  /// **NOTE:**
  /// call this to finish the load data,
  /// don't need to call [finishLoadData] anymore
  Future<void> saveCacheAndFinish({
    T? data,
    List<T> list = const [],
  }) async {
    try {
      if (data != null) {
        await storage.save<String>(cachedKey, jsonEncode(CachedModelConverter<T>().toJson(data)));
      }
      if (list.isNotEmpty) {
        await storage.save<String>(cachedKey, json.encode(list));
      }
      finishLoadData(data: data, list: list);
    } catch (e) {
      debugPrint('Failed save cache, $e');
      showError(e.toString());
    }
  }

  /// **NOTE:**
  /// call this [finishLoadData] instead [saveCacheAndFinish] if the data
  /// is not require to saved in local data
  finishLoadData({
    T? data,
    List<T> list = const [],
  }) {
    if (data != null) dataObj.value = data;
    if (list.isNotEmpty) dataList.value = list;
    dismissLoading();
  }

  /// **NOTE:**
  /// call this [closePage] instead of [onClose] when you need to dispose anything
  void closePage() {}

  @override
  void onClose() {
    closePage();
    super.onClose();
  }
}
