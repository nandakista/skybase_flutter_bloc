import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/config/base/pagination_mixin.dart';
import 'package:skybase/config/blocs/hydrated_cache_mixin.dart';

/// Base bloc with several generic type, each description of type explained below :
/// - T is type data
/// - E is event bloc
/// - S is state bloc
abstract class PaginationHydratedBloc<T, E, S> extends HydratedBloc<E, S>
    with PaginationMixin<T>, HydratedCacheMixin<T> {
  final String _tag = 'PaginationBloc::->';

  CancelToken cancelToken = CancelToken();

  PaginationHydratedBloc(super.state);

  /// For persist data when paging init
  List<T>? _tempData = [];

  /// Must be call this in init state for make pagination not loading
  void loadPagingData({
    required Future Function() onLoad,
    required bool until,
  }) {
    try {
      if (until) {
        pagingController.value = PagingState(
          nextPageKey: page,
          error: null,
          itemList: _tempData,
        );
      }
      loadData(onLoad);
    } catch (e) {
      log('$_tag Failed to load paging data');
    }
  }

  /// Manipulate hydrated saving cache for pagination to only cache page 1
  @override
  Map<String, dynamic>? saveCacheList(List<T> data) {
    if (page == 1) {
      _tempData = data;
      return super.saveCacheList(data);
    } else {
      _tempData?.clear();
      return null;
    }
  }

  void onClose() {}

  @protected
  @override
  @mustCallSuper
  Future<void> close() {
    pagingController.dispose();
    cancelToken.cancel();
    return super.close();
  }
}
