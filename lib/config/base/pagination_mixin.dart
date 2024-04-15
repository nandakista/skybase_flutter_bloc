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

  Future Function()? _onLoad;

  void loadData(Future Function() onLoad) async {
    pagingController.addPageRequestListener(
      (page) async {
        if (page > 1) Future.microtask(() => onLoad());
      },
    );
    if (page == 1) await onLoad();
    this._onLoad = onLoad;
  }

  void onRefresh() async {
    try {
      if (_onLoad != null) {
        page = 1;
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

  void loadNextData({required List<T> data}) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      if (page == 1 && (pagingController.itemList ?? []).isNotEmpty) {
        pagingController.itemList?.clear();
      }
      this.page++;
      pagingController.appendPage(data, page);
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
