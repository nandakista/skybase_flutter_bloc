import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

mixin PaginationMixin<T> {
  final String _tag = 'PaginationMixin::->';

  StorageManager storage = StorageManager.instance;

  final pagingController = PagingController<int, T>(firstPageKey: 1);
  final int perPage = 20;
  int page = 1;

  /// Set to true to make data persistent when pull to refresh triggered.
  /// Set to false to show shimmer every pull to refresh triggered.
  bool get keepAlive => false;

  Future Function()? _onLoad;

  void loadData(Future Function() onLoad) async {
    pagingController.addPageRequestListener(
      (page) async {
        if (page > 1) Future.microtask(() => onLoad());
      },
    );
    this._onLoad = onLoad;
    if (page == 1) await onLoad();
  }

  Future<void> onRefresh([BuildContext? context]) async {
    try {
      if (_onLoad != null) {
        if (page > 1) {
          page = 1;
          pagingController.value = PagingState(
            nextPageKey: page,
            error: null,
            itemList: keepAlive ? _keepAliveData : null,
          );
        }
        await _onLoad!();
      }
    } catch (e) {
      log('$_tag Error $e');
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
