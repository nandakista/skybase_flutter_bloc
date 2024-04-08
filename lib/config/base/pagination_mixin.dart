import 'dart:developer';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

mixin PaginationMixin<T> {
  final String tag = 'PaginationMixin::->';

  StorageManager storage = StorageManager.instance;

  final pagingController = PagingController<int, T>(firstPageKey: 1);
  final int perPage = 20;
  int page = 1;

  bool get keepAlivePaging => false;

  String get cachedKey => '';

  Future Function()? _onLoad;

  void loadData(Future Function() onLoad) {
    pagingController.addPageRequestListener(
      (page) async {
        if (page > 1) Future.microtask(() => onLoad());
      },
    );
    if (page == 1) onLoad();
    this._onLoad = onLoad;
  }

  void onRefresh() async {
    try {
      if (_onLoad != null) {
        page = 1;
        if (cachedKey.isNotEmpty) {
          await storage.delete(cachedKey.toString());
        }
        pagingController.value = PagingState(
          nextPageKey: page,
          error: null,
          itemList: keepAlivePaging ? _keepAliveData : null,
        );
        await _onLoad!();
      }
    } catch (e) {
      log('$tag Error $e');
    }
  }

  void loadNextData({required List<T> data, int? page}) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      pagingController.appendPage(data, page ?? this.page++);
    }
  }

  void loadError(String message) {
    pagingController.error = message;
  }

  List<T> get _keepAliveData {
    List<T> dataList = pagingController.itemList ?? [];
    if (dataList.length >= perPage) {
      return dataList.sublist(0, perPage);
    } else {
      return dataList;
    }
  }
}
