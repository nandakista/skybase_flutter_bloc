import 'dart:developer';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

mixin PaginationMixin<T> {
  final String tag = 'PaginationMixin::->';

  StorageManager storage = StorageManager.instance;

  final pagingController = PagingController<int, T>(firstPageKey: 0);
  final int perPage = 20;
  int page = 1;

  void loadData(Function() onLoad) {
    _initListener(() => Future.microtask(onLoad));
  }

  void _initListener(void Function() onLoad) {
    pagingController.addPageRequestListener((page) => onLoad());
  }

  Future<void> onRefresh() async {
    try {
      page = 1;
      pagingController.refresh();
    } catch (e) {
      log('$tag Error $e');
    }
  }

  Future<void> deleteCached(String cacheKey) async {
    await storage.delete(cacheKey.toString());
  }

  void finishLoadData({required List<T> data, int? page}) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      pagingController.appendPage(data, page ?? this.page++);
    }
  }

  void showError(String message) {
    pagingController.error = message;
  }
}
